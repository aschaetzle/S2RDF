SELECT tab0.v1 AS v1 , tab4.v5 AS v5 , tab5.v6 AS v6 , tab3.v4 AS v4 , tab2.v3 AS v3 , tab1.v2 AS v2 
 FROM    (SELECT obj AS v1 
	 FROM gr__offers$$1$$ 
	 WHERE sub = 'wsdbm:Retailer644' AND OSgr__includes=true
	) tab0
 JOIN    (SELECT sub AS v1 , obj AS v2 
	 FROM gr__includes$$2$$ 
	 WHERE SOgr__offers=true AND OSsorg__director=true
	) tab1
 ON(tab0.v1=tab1.v1)
 JOIN    (SELECT obj AS v3 , sub AS v2 
	 FROM sorg__director$$3$$
	 
	 WHERE SOgr__includes=true AND OSwsdbm__friendOf=true
	) tab2
 ON(tab1.v2=tab2.v2)
 JOIN    (SELECT obj AS v4 , sub AS v3 
	 FROM wsdbm__friendOf$$4$$
	 
	 WHERE SOsorg__director=true AND OSwsdbm__friendOf=true
	) tab3
 ON(tab2.v3=tab3.v3)
 JOIN    (SELECT obj AS v5 , sub AS v4 
	 FROM wsdbm__friendOf$$5$$
	 
	 WHERE SOwsdbm__friendOf=true AND OSwsdbm__likes=true
	) tab4
 ON(tab3.v4=tab4.v4)
 JOIN    (SELECT sub AS v5 , obj AS v6 
	 FROM wsdbm__likes$$6$$ 
	 WHERE SOwsdbm__friendOf=true
	) tab5
 ON(tab4.v5=tab5.v5)


++++++Tables Statistic
wsdbm__likes$$6$$	0	VP	wsdbm__likes
	VP	<wsdbm__likes>	112401
	SO	<wsdbm__likes><wsdbm__friendOf>	112401	1.0
------
sorg__director$$3$$	2	VP	sorg__director
	VP	<sorg__director>	1312
	SO	<sorg__director><gr__includes>	1279	0.97
	OS	<sorg__director><wsdbm__friendOf>	615	0.47
------
gr__offers$$1$$	0	VP	gr__offers
	VP	<gr__offers>	119316
	OS	<gr__offers><gr__includes>	119316	1.0
------
wsdbm__friendOf$$4$$	1	VP	wsdbm__friendOf
	VP	<wsdbm__friendOf>	4491142
	SO	<wsdbm__friendOf><sorg__director>	31946	0.01
	OS	<wsdbm__friendOf><wsdbm__friendOf>	1787147	0.4
------
gr__includes$$2$$	2	VP	gr__includes
	VP	<gr__includes>	90000
	SO	<gr__includes><gr__offers>	44841	0.5
	OS	<gr__includes><sorg__director>	4790	0.05
------
wsdbm__friendOf$$5$$	2	VP	wsdbm__friendOf
	VP	<wsdbm__friendOf>	4491142
	SO	<wsdbm__friendOf><wsdbm__friendOf>	4491142	1.0
	OS	<wsdbm__friendOf><wsdbm__likes>	1074144	0.24
------
