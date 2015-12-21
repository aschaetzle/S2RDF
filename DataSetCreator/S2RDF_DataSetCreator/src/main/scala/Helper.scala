/* Copyright Simon Skilevic
 * Master Thesis for Chair of Databases and Information Systems
 * Uni Freiburg
 */

package dataCreator
import scala.sys.process._
import java.io.File
/**
 * The set of different help-functions 
 * TODO: move to the places, where they are used due to small number of 
 * functions
 */
object Helper {
  
  /**
   * Checks if the table which we want to create is already in HDFS
   */
  def checkIfAlreadyCreated(pred: String, relType:String):Boolean = {
    if (relType == "SS" && !fileExists(Settings.extVpDir 
                                       + getPartName(pred)
                                       + ".parquet")) {
      return false
    }
    
    if (relType == "SO" && !fileExists(Settings.extVpDir 
                                       + getPartName(pred)
                                       + "SO.parquet")) {
      return false
    }
    
    if (relType == "OS" && !fileExists(Settings.extVpDir 
                                       + getPartName(pred)
                                       + "OS.parquet")) {
      return false
    }
    
    true
  }

  /**
   * transform table name for storage table in HDFS
   */ 
  def getPartName(v: String): String = {
    v.replaceAll(":", "__")
  }
  
  /**
   * Float to String formated
   */
  def fmt(v: Any): String = v match {
    case d : Double => "%1.2f" format d
    case f : Float => "%1.2f" format f
    case i : Int => i.toString
    case _ => throw new IllegalArgumentException
  }
  
  /**
   * get ratio a/b as formated string
   */
  def ratio(a: Long, b: Long): String = {
    fmt((a).toFloat/(b).toFloat)
  }    
  
  /**
   * remove directory in HDFS (if not exists -> it's ok :))
   */
  def removeDirInHDFS(path: String) = {
    val cmd = "hdfs dfs -rm -f -r " + path    
    val output = cmd.!!
  }
  
  /**
   * create directory in HDFS
   */
  def createDirInHDFS(path: String) = {       
    try{
      val cmd = "hdfs dfs -mkdir " + path
      val output = cmd.!!
    } catch {
      case e: Exception => println("Cannot create directory->" 
                                   + path + "\n" + e)
    }
  }
  
  /**
   * Checks if file or directory exists in hdfs
   */
  def fileExists(fileName: String): Boolean = {
    val conf = Settings.sparkContext.hadoopConfiguration
    val fs = org.apache.hadoop.fs.FileSystem.get(conf)
    fs.exists(new org.apache.hadoop.fs.Path(fileName))
  }
  
  /**
   * check if file exists in local hardrive(not HDFS)
   */
  def fileExistsLocally(fileName: String): Boolean = {
    var f = new File(fileName)
    if (f.exists())
      return true
    false
  }
}
