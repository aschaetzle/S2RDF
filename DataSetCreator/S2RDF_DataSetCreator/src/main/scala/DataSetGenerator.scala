/* Copyright Simon Skilevic
 * Master Thesis for Chair of Databases and Information Systems
 * Uni Freiburg
 */
 
package dataCreator
import collection.mutable.HashMap
import collection.mutable.ArrayBuffer
/**
 * DataSetGenerator creates for an input RDF dataset its reprsentations as 
 * Triple Table, Vertical Partiitoning and Extended Vertical Partitioning in 
 * HDFS.
 * TT has to be created before VP and VP before ExtVP, since VP is used for 
 * ExtVP generating and TT is used for creation of VP and ExtVP.
 * 
 * The informations about created tables are saved to the statistics files using
 * StatisticWriter
 */
object DataSetGenerator {
  
  // Spark initialization
  private val _sc = Settings.sparkContext
  private val _sqlContext = Settings.sqlContext
  import _sqlContext.implicits._
  
  // number of triples in input dataset
  private var _inputSize = 0: Long
  // number of triples for every VP table  
  private var _vpTableSizes = new HashMap[String, Long]()
  // set of unique predicates from input RDF dataset
  private var _uPredicates = null: Array[String]
  
  /**
   * generate all datasets (TT, VP, ExtVP)
   * It becomes as an input a varible containing string ("VP","SO","OS","SS")
   * Functions creates --> 
   *  TT and VP tables for "VP"
   *  Loads TT, VP to the main memory and creates SO for input string "SO"
   *  Loads TT, VP to the main memory and creates OS for input string "OS"
   *  Loads TT, VP to the main memory and creates SS for input string "SS"
   *  
   *  The program assumes that TT and VP are already generated for creation of
   *  SO,OS,SS
   */
  def generateDataSet(datasetType: String) = {
    
    // create or load TripleTable if already created
    if (datasetType == "VP" && !Helper.fileExists(Settings.tripleTable)) 
      createTT() 
    else 
      loadTT()
    // extarct all unique predicates from TripleTable
    // necessary for VP/ExtVP generation
    _uPredicates = _sqlContext.sql("select distinct pred from triples")
                              .map(t => t(0).toString())
                              .collect()

    StatisticWriter.init(_uPredicates.size, _inputSize)
    
    // create or load Vertical Partitioning if already exists
    if (datasetType == "VP" && !Helper.fileExists(Settings.vpDir)) 
      createVP() 
    else if (datasetType != "VP")
      loadVP()
        
    // create Extended Vertical Partitioning table set definded by datasetType
    if (datasetType == "SO") createExtVP("SO")
    else if (datasetType == "OS") createExtVP("OS")
    else if (datasetType == "SS") createExtVP("SS")
  }

  // Triple Table schema
  case class Triple(sub: String, pred: String, obj: String)

  /**
   * Generate TripleTable and save it to Parquet file in HDFS.
   * The table has to be cached, since it is used for generation of VP and ExtVP
   */
  private def createTT() = {
    val df = _sc.textFile(Settings.inputRDFSet)
                         .map(_.split("\t"))
                         .map(p => Triple(p(0), p(1), p(2)))
                         .toDF()
    // Commented out due to execution problem for dataset of 1 Bil triples
    // We do not need it anyway if the input dataset is correct and has no
    // double ellements. It was not the case for WatDiv
    //                     .distinct  
    df.registerTempTable("triples")     
    _sqlContext.cacheTable("triples")
    _inputSize = df.count()
    
    // remove old TripleTable and save it as Parquet
    //Helper.removeDirInHDFS(Settings.tripleTable)
    df.saveAsParquetFile(Settings.tripleTable)
  }
  
  /**
   * Loads TT table and caches it to main memory.
   * TT table is used for generation of ExtVP and VP tables
   */
  private def loadTT() = {  
    val df = _sqlContext.parquetFile(Settings.tripleTable);
    df.registerTempTable("triples")     
    //_sqlContext.cacheTable("triples")
    _inputSize = df.count()
  }
  
  /**
   * Generates VP table for each unique predicate in input RDF dataset.
   * All tables have to be cached, since they are used for generation of ExtVP 
   * tables.
   */
  private def createVP() = {    
    // create directory for all vp base tables
    //Helper.removeDirInHDFS(Settings.vpDir)
    if (!Helper.fileExists(Settings.vpDir))
      Helper.createDirInHDFS(Settings.vpDir)
    //Helper.removeDirInHDFS(Settings.extVpDir)
    if (!Helper.fileExists(Settings.extVpDir))
      Helper.createDirInHDFS(Settings.extVpDir)
    StatisticWriter.initNewStatisticFile("VP")

    // create and cache vpTables for all predicates in input RDF dataset
    for (predicate <- _uPredicates){      
      var vpTable = _sqlContext.sql("select distinct sub, obj "
                                  + "from triples where pred='"+predicate+"'")          
      
      val cleanPredicate = Helper.getPartName(predicate)    
      vpTable.registerTempTable(cleanPredicate)
      _sqlContext.cacheTable(cleanPredicate)
      _vpTableSizes(predicate) = vpTable.count()
      
      // save VP table twice: one for VP model
      vpTable.saveAsParquetFile(Settings.vpDir + cleanPredicate + ".parquet")
            
      // print statistic line
      StatisticWriter.incSavedTables()
      StatisticWriter.addTableStatistic("<" + predicate + ">", 
                                        -1, 
                                        _vpTableSizes(predicate)) 
    }
    
    StatisticWriter.closeStatisticFile()
  }
  
  /**
   * Loads VP tables and caches them to main memory.
   * VP tables are used for generation of ExtVP tables
   */
  private def loadVP() = {  
    for (predicate <- _uPredicates){      
      val cleanPredicate = Helper.getPartName(predicate)    
      var vpTable = _sqlContext.parquetFile(Settings.vpDir 
                                            + cleanPredicate 
                                            + ".parquet")          
            
      vpTable.registerTempTable(cleanPredicate)
      _sqlContext.cacheTable(cleanPredicate)
      _vpTableSizes(predicate) = vpTable.count()
    }
  }
  
    /**
   * Load subjects (sub, pred) and objects (pred, obj) tables 
   */
  private def loadSubjectsAndObjectsTables() = {
    val subjects = _sqlContext.sql("select distinct sub as s, pred as p from triples")
    subjects.registerTempTable("subjects")
    _sqlContext.cacheTable("subjects")
    var s = subjects.count()
    
    val objects = _sqlContext.sql("select distinct pred as p, obj as o from triples")
    objects.registerTempTable("objects")
    _sqlContext.cacheTable("objects")
    var o = objects.count()    
    
  }
  
   /**
    * saveEndTable
    */
   private def saveBigTable(pred:String, 
                            tableSS:org.apache.spark.sql.DataFrame,
                            tableNameSS:String) = {
      val cleanPredicate = Helper.getPartName(pred)
      
//      var tableSS = null:org.apache.spark.sql.DataFrame
//      
//      if (Helper.fileExists(Settings.extVpDir + cleanPredicate + "SS.parquet"))
//        tableSS = _sqlContext.parquetFile(Settings.extVpDir + cleanPredicate 
//                                          + "SS.parquet")
//      else
//        tableSS = _sqlContext.parquetFile(Settings.vpDir + cleanPredicate
//                                          + ".parquet")    
//      val tableNameSS = cleanPredicate + "bigtableSS_1"
//      tableSS.registerTempTable(tableNameSS)
    
      var tableSO = null:org.apache.spark.sql.DataFrame
      
      if (Helper.fileExists(Settings.extVpDir + cleanPredicate + "SO.parquet"))
        tableSO = _sqlContext.parquetFile(Settings.extVpDir + cleanPredicate 
                                          + "SO.parquet")
      else
        tableSO = _sqlContext.parquetFile(Settings.vpDir + cleanPredicate
                                          + ".parquet")    
      val tableNameSO = cleanPredicate + "bigtableSO"
      tableSO.registerTempTable(tableNameSO)
      
      var tableOS = null:org.apache.spark.sql.DataFrame
      if (Helper.fileExists(Settings.extVpDir + cleanPredicate + "OS.parquet"))
        tableOS = _sqlContext.parquetFile(Settings.extVpDir + cleanPredicate
                                          + "OS.parquet")
      else
        tableOS = _sqlContext.parquetFile(Settings.vpDir + cleanPredicate
                                          + ".parquet")
      val tableNameOS = cleanPredicate + "bigtableOS"
      tableOS.registerTempTable(tableNameOS)
      
      var columns = new ArrayBuffer[String]()
      
      // add SS columns
      for (cl <- tableSS.columns){
        if (cl!="sub" && cl!="obj")
          columns += cl
      }
      
      // add SO columns
      for (cl <- tableSO.columns){
        if (cl!="sub" && cl!="obj")
          columns += cl
      }
      
      // add OS columns
      for (cl <- tableOS.columns){
        if (cl!="sub" && cl!="obj")
          columns += cl
      }
      
      var selectors = columns.mkString(", ")
      val command = ("select ss.sub as sub, ss.obj as obj, " 
                     + selectors + " from " + tableNameSS + " ss "
                     + "inner join " + tableNameSO 
                     + " so on(ss.sub=so.sub and ss.obj=so.obj) "
                     + "inner join " + tableNameOS +" os"
                     + " on(ss.sub=os.sub and ss.obj=os.obj) ")
      var res = _sqlContext.sql(command)

      res.saveAsParquetFile(Settings.extVpDir 
                            + cleanPredicate + ".parquet")
      
      println("FULL TABLE ("+cleanPredicate+")->")
      //res.show()
      
      // remove OS- and SO-BigTables
      if (Helper.fileExists(Settings.extVpDir + cleanPredicate + "SO.parquet")) 
        Helper.removeDirInHDFS(Settings.extVpDir 
                               + cleanPredicate + "SO.parquet")
      if (Helper.fileExists(Settings.extVpDir + cleanPredicate + "OS.parquet")) 
        Helper.removeDirInHDFS(Settings.extVpDir 
                               + cleanPredicate + "OS.parquet")
   }
   /**
    * Load ExtVP_BigTable for given predicate and returns the list of column
    * names. If ExtVP_BigTable doesn't exist jet then load vp table with same
    * pradicate
    */
   private def loadExtVP_BigTable(pred: String) : ArrayBuffer[String] = {      
      val cleanPredicate = Helper.getPartName(pred)
      val tablePath = Settings.extVpDir + cleanPredicate + ".parquet";
      var vpTable = null: org.apache.spark.sql.DataFrame
      
      if (Helper.fileExists(tablePath)){
        vpTable = _sqlContext.parquetFile(tablePath)
      } else {
        vpTable = _sqlContext.parquetFile(Settings.vpDir 
                                          + cleanPredicate 
                                          + ".parquet")
      }
      
      vpTable.registerTempTable(cleanPredicate+"bigtable0")
      var res = new ArrayBuffer[String]()
      vpTable.columns.foreach(t => res += t)
      res
   }
   
   
  /**
   * Generates ExtVP tables for all (relType(SO/OS/SS))-relations of all 
   * VP tables to the other VP tables 
   */
  private def createExtVP(relType: String) = {

    loadSubjectsAndObjectsTables()
    
    StatisticWriter.initNewStatisticFile(relType)
    
    var savedTables = 0
    var unsavedNonEmptyTables = 0
    var createdDirs = List[String]()
    
    // for every VP table generate a set of ExtVP tables, which represent its
    // (relType)-relations to the other VP tables
    for (pred1 <- _uPredicates) if (!Helper.checkIfAlreadyCreated(pred1, 
                                                                  relType)){
      println("pred1->"+pred1)
      // get all predicates, whose TPs are in (relType)-relation with TP
      // (?x, pred1, ?y)
      var relatedPredicates = getRelatedPredicates(pred1, relType)
      
      // load base extVP_BigTable for actual predicate and save column names 
      var colNames = loadExtVP_BigTable(pred1)
      
      // save the names of all created tables to remove 
      // them in the moment where we dont need them anymore
      var registeredTables = new ArrayBuffer[String]
      registeredTables += (Helper.getPartName(pred1) + "bigtable0")
             
      var extVpBigTable = new ArrayBuffer[org.apache.spark.sql.DataFrame]

      var tableId = 0;
      
      for (pred2 <- relatedPredicates) {                
        println("\tpred2->"+pred2)
        var extVpTableSize = -1: Long
        
        // we avoid generation of ExtVP tables corresponding to subject-subject
        // relation to it self, since such tables are always equal to the
        // corresponding VP tables
        if (!(relType == "SS" && pred1 == pred2)) {
          var sqlCommand = ""
          // create ext_vp table for pred1<->pred2 relation
//          var sqlCommand = getExtVpSQLcommand(pred1, pred2, relType)
//          println("\t\textB")
//          var extVpTable = _sqlContext.sql(sqlCommand)
//          println("\t\textM")
//          extVpTable.registerTempTable("extvp_table" + tableId)          
//          //_sqlContext.cacheTable("extvp_table" + tableId)
//          registeredTables += ("extvp_table" + tableId)
//          //extVpTableSize = extVpTable.count()
          extVpTableSize = 1
//          println("\t\textE")
          if (extVpTableSize == _vpTableSizes(pred1)){
            sqlCommand = getExtVPBigTableOnesColumnSQLcommand(pred1, 
                                                              pred2, 
                                                              relType,
                                                              tableId,
                                                              colNames)            
            println("\t\tBigTableB")
            extVpBigTable += _sqlContext.sql(sqlCommand)            
            println("\t\tBigTableM")
            var newTabName = (Helper.getPartName(pred1) 
                              + "bigtable" + (tableId+1))
            extVpBigTable.last.registerTempTable(newTabName)
            registeredTables += newTabName            
            //_sqlContext.cacheTable(newTabName)
            //extVpBigTable.last.persist(org.apache.spark.storage.StorageLevel.MEMORY_AND_DISK)
            //extVpBigTable.last.count()
            println("\t\tBigTableE")
            // uncache extvpbigtable from old iteration
//            if (tableId > 0) {
//              extVpBigTable(extVpBigTable.size-2).unpersist()
//            }
            
            extVpTableSize = _vpTableSizes(pred1)
          } else {
            sqlCommand = getExtVPBigTableSQLcommand(pred1, 
                                                    pred2, 
                                                    relType,
                                                    tableId,
                                                    colNames)
            println("\t\tBigTableBB")
            extVpBigTable += _sqlContext.sql(sqlCommand)
            println(1)
            var newTabName = (Helper.getPartName(pred1) + "bigtable" + (tableId+1))
            println(2)
            extVpBigTable.last.registerTempTable(newTabName)
            println(3)
            registeredTables += newTabName
            println(4)
            //_sqlContext.cacheTable(newTabName)
            //extVpBigTable.last.persist(org.apache.spark.storage.StorageLevel.MEMORY_AND_DISK)
            println(5)
            //extVpBigTable.last.count()
            println("\t\tBigTableEE")
            // uncache extvpbigtable from old iteration
//            if (tableId > 0) {
//              extVpBigTable(extVpBigTable.size-2).unpersist()
//            }

          }
            
          StatisticWriter.incSavedTables()          
          //_sqlContext.uncacheTable("extvp_table" + tableId)
          
        } else {
          var sqlCommand = getExtVPBigTableOnesColumnSQLcommand(pred1, 
                                                                 pred2, 
                                                                 relType,
                                                                 tableId,
                                                                 colNames)
          println("\t\tBigTableBBB")
          extVpBigTable += _sqlContext.sql(sqlCommand)
          var newTabName = (Helper.getPartName(pred1) + "bigtable" + (tableId+1))
          extVpBigTable.last.registerTempTable(newTabName)
          registeredTables += newTabName
          extVpTableSize = _vpTableSizes(pred1)
          //_sqlContext.cacheTable(newTabName)
          //extVpBigTable.last.persist(org.apache.spark.storage.StorageLevel.MEMORY_AND_DISK)
          //extVpBigTable.last.count()
          println("\t\tBigTableEEE")
          // uncache extvpbigtable from old iteration
//          if (tableId > 0) {
//            extVpBigTable(extVpBigTable.size-2).unpersist()
//          }
        }

        // add ColumnNames for the added column        
        var newColumn = (relType + Helper.getPartName(pred2))
        colNames += newColumn
        
        // print statistic line
        // save statistics about all ExtVP tables > 0, even about those, which
        // > then ScaleUB.
        // We need statistics about all non-empty tables 
        // for the Empty Table Optimization (avoiding query execution for
        // the queries having triple pattern relations, which lead to empty
        // result)
        StatisticWriter.addTableStatistic("<" + pred1 + "><" + pred2 + ">", 
                                          extVpTableSize, 
                                          _vpTableSizes(pred1))
        tableId+=1;
      }
      if (extVpBigTable.size > 0 && extVpBigTable.last != null) {
        
        println("\nEndTable "+pred1+"_BigTable")
        //extVpBigTable.last.show()  
        println()
        
        // store result ExtVp_BigTable to HDFS for given prdicate pred1
        if (Helper.fileExists(Settings.extVpDir 
                              + Helper.getPartName(pred1) + ".parquet")) {
          Helper.removeDirInHDFS(Settings.extVpDir 
                                 + Helper.getPartName(pred1) + ".parquet")
        } 
        println("Save...")
        if (relType == "SS") {
//          extVpBigTable.last.saveAsParquetFile(Settings.extVpDir 
//                                      + Helper.getPartName(pred1) 
//                                      + relType + ".parquet")
          saveBigTable(pred1, 
                       extVpBigTable.last, 
                       Helper.getPartName(pred1) 
                        + "bigtable" + (tableId))
        }
        else
          extVpBigTable.last.saveAsParquetFile(Settings.extVpDir 
                                      + Helper.getPartName(pred1) 
                                      + relType + ".parquet")
        println("Saved")
      }
            
      // unregister created tables     
      for(tab <- registeredTables.reverse){
        _sqlContext.dropTempTable(tab)
      }

    }
    
    StatisticWriter.closeStatisticFile()
    
  }

  /**
   * Returns all predicates, whose triple patterns are in (relType)-relation 
   * with TP of predicate pred.
   */
  private def getRelatedPredicates(pred: String, relType: String)
                : Array[String] = {  
    var sqlRelPreds = ("select distinct pred "
                        + "from triples t1 "
                        + "left semi join "+Helper.getPartName(pred) + " t2 "
                        + "on")

    if (relType == "SS"){
      sqlRelPreds += "(t1.sub=t2.sub)"
    } else if (relType == "OS"){
      sqlRelPreds += "(t1.sub=t2.obj)"
    } else if (relType == "SO"){
      sqlRelPreds += "(t1.obj=t2.sub)"
    }  

    _sqlContext.sql(sqlRelPreds).map(t => t(0).toString()).collect()
  }
  
  /**
   * Get command to create a table which we will join to result table to
   * generate new column in result table. This column corresponds to the
   * relation relType of pred1 to pred2
   */
//  private def getRelationsCommand(pred1: String, 
//                                  pred2: String, 
//                                  relType: String): String = {
//    var newColumnName = (relType + Helper.getPartName(pred2))
//    var command = ("select t1.sub as s, t1.obj as o, "
//                    + "true as " + newColumnName
//                    + " from ")
//
//    if (relType == "SS"){
//      command += "subjects t1 where t2.pred=" + pred2
//    } else if (relType == "OS"){
//      command += "subjects t1 where t2.pred=" + pred2
//    } else if (relType == "SO"){
//      command += "objects t1 where t2.pred=" + pred2
//    }
//    // println(command)
//    command
//  }
  
  /**
   * Generates SQL query to obtain ExtVP_(relType)pred1|pred2 table containing
   * all triples(pairs) from VPpred1, which are linked by (relType)-relation
   * with some other pair in VPpred2
   */
  private def getExtVpSQLcommand(pred1: String, 
                                 pred2: String, 
                                 relType: String): String = {
    var newColumnName = (relType + Helper.getPartName(pred2))
    var command = ("select t1.sub as s, t1.obj as o, "
                    + "true as " + newColumnName
                    + " from " + Helper.getPartName(pred1) + " t1 "
                    + "left semi join " + Helper.getPartName(pred2) + " t2 "
                    + "on ")

    if (relType == "SS"){
      command += "(t1.sub=t2.sub)"
    } else if (relType == "OS"){
      command += "(t1.obj=t2.sub)"
    } else if (relType == "SO"){
      command += "(t1.sub=t2.obj)"
    }
    // println(command)
    command
  }
 
   /**
    * Generates SQL command to extend ExtVP_BigTable by a column containing
    * only true entries
    */
  private def getExtVPBigTableOnesColumnSQLcommand(pred1:String,
                                                   pred2:String,
                                                   relType:String,
                                                   tId:Int,
                                                   colNames:ArrayBuffer[String])
                                                  : String = {
    var newColumnName = (relType + Helper.getPartName(pred2))
    var selectors = (colNames.mkString(", ") 
                      + ", true as " + newColumnName)
    var command = ("select " + selectors 
                    + " from " + Helper.getPartName(pred1)+"bigtable"+tId)
    println(command)
    command
  }
 
  /**
   * Generate SQL command to extend BigTable for a given pred1 by new column
   * which corresponds to (relType)-relation of pred1 to pred2
   */
  private def getExtVPBigTableSQLcommand(pred1:String,
                                         pred2:String,
                                         relType:String,
                                         tId:Int,
                                         colNames:ArrayBuffer[String])
                : String = {
    var newColumnName = (relType + Helper.getPartName(pred2))
    //var alias = colNames.map(t => t + " as " + t)
    var alias = colNames
    
    var condition = ""
    if (relType == "SS")
      condition = "case when t2.s is NULL then false ELSE true end"
    else if (relType == "SO")
      condition = "case when t2.o is NULL then false ELSE true end"
    else if (relType == "OS")
      condition = "case when t2.s is NULL then false ELSE true end"
    
    var selectors = ("" + alias.mkString(", ") 
                     + ", " + condition + " as "+ newColumnName)

    var command = ("select " + selectors 
                    + " from " + Helper.getPartName(pred1) 
                    + "bigtable" + tId +" t1")
    
    if (relType == "SS")
      command += " left outer join subjects t2 on (sub=s and p='"+pred2+"')"
    else if (relType == "SO")
      command += " left outer join objects t2 on (sub=o and p='"+pred2+"')"
    else if (relType == "OS")
      command += " left outer join subjects t2 on (obj=s and p='"+pred2+"')"

    println(command)
    command
  }
}
