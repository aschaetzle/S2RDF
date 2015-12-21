SELECT tab0.v1 AS v1 , tab1.v0 AS v0 , tab4.v5 AS v5 , tab5.v6 AS v6 , tab3.v4 AS v4 , tab2.v3 AS v3 
 FROM    (SELECT obj AS v0 
	 FROM gr__offers$$2$$ 
	 WHERE sub = 'wsdbm:Retailer346' AND OSgr__includes=true AND OSgr__price=true AND OSgr__validThrough=true
	) tab1
 JOIN    (SELECT sub AS v0 , obj AS v4 
	 FROM gr__validThrough$$4$$
	 
	 WHERE SSgr__includes=true AND SOgr__offers=true AND SSgr__price=true
	) tab3
 ON(tab1.v0=tab3.v0)
 JOIN    (SELECT obj AS v1 , sub AS v0 
	 FROM gr__includes$$1$$ 
	 WHERE SOgr__offers=true AND SSgr__price=true AND SSgr__validThrough=true AND OSog__title=true AND OSrdf__type=true
	) tab0
 ON(tab3.v0=tab0.v0)
 JOIN    (SELECT sub AS v1 , obj AS v5 
	 FROM og__title$$5$$ 
	 WHERE SOgr__includes=true AND SSrdf__type=true
	) tab4
 ON(tab0.v1=tab4.v1)
 JOIN    (SELECT sub AS v1 , obj AS v6 
	 FROM rdf__type$$6$$ 
	 WHERE SOgr__includes=true AND SSog__title=true
	) tab5
 ON(tab4.v1=tab5.v1)
 JOIN    (SELECT sub AS v0 , obj AS v3 
	 FROM gr__price$$3$$ 
	 WHERE SSgr__includes=true AND SOgr__offers=true AND SSgr__validThrough=true
	) tab2
 ON(tab0.v0=tab2.v0)


++++++Tables Statistic
gr__includes$$1$$	3	VP	gr__includes
	VP	<gr__includes>	90000
	SO	<gr__includes><gr__offers>	44841	0.5
	SS	<gr__includes><gr__price>	90000	1.0
	SS	<gr__includes><gr__validThrough>	36346	0.4
	OS	<gr__includes><og__title>	90000	1.0
	OS	<gr__includes><rdf__type>	90000	1.0
------
gr__offers$$2$$	3	VP	gr__offers
	VP	<gr__offers>	119316
	OS	<gr__offers><gr__includes>	119316	1.0
	OS	<gr__offers><gr__price>	119316	1.0
	OS	<gr__offers><gr__validThrough>	45983	0.39
------
og__title$$5$$	1	VP	og__title
	VP	<og__title>	25000
	SO	<og__title><gr__includes>	24274	0.97
	SS	<og__title><rdf__type>	25000	1.0
------
rdf__type$$6$$	1	VP	rdf__type
	VP	<rdf__type>	136215
	SO	<rdf__type><gr__includes>	24274	0.18
	SS	<rdf__type><og__title>	25000	0.18
------
gr__validThrough$$4$$	2	VP	gr__validThrough
	VP	<gr__validThrough>	36346
	SS	<gr__validThrough><gr__includes>	36346	1.0
	SO	<gr__validThrough><gr__offers>	17984	0.49
	SS	<gr__validThrough><gr__price>	36346	1.0
------
gr__price$$3$$	3	VP	gr__price
	VP	<gr__price>	240000
	SS	<gr__price><gr__includes>	90000	0.38
	SO	<gr__price><gr__offers>	44841	0.19
	SS	<gr__price><gr__validThrough>	36346	0.15
------
