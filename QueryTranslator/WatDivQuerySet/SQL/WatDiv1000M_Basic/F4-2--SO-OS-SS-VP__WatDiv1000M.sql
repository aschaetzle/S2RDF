SELECT tab7.v1 AS v1 , tab0.v0 AS v0 , tab8.v7 AS v7 , tab5.v5 AS v5 , tab6.v6 AS v6 , tab3.v4 AS v4 , tab1.v2 AS v2 , tab4.v8 AS v8 
 FROM    (SELECT sub AS v1 
	 FROM sorg__language$$8$$
	 
	 WHERE obj = 'wsdbm:Language0' AND SOfoaf__homepage=true AND SSsorg__url=true AND SSwsdbm__hits=true
	) tab7
 JOIN    (SELECT obj AS v1 , sub AS v0 
	 FROM foaf__homepage$$1$$
	 
	 WHERE SOgr__includes=true AND SSog__tag=true AND SSsorg__description=true AND SSsorg__contentSize=true AND OSsorg__url=true AND OSwsdbm__hits=true AND OSsorg__language=true AND SOwsdbm__likes=true
	) tab0
 ON(tab7.v1=tab0.v1)
 JOIN    (SELECT sub AS v0 
	 FROM og__tag$$3$$ 
	 WHERE obj = 'wsdbm:Topic59' AND SSfoaf__homepage=true AND SOgr__includes=true AND SSsorg__description=true AND SSsorg__contentSize=true AND SOwsdbm__likes=true
	) tab2
 ON(tab0.v0=tab2.v0)
 JOIN    (SELECT sub AS v0 , obj AS v8 
	 FROM sorg__contentSize$$5$$
	 
	 WHERE SSfoaf__homepage=true AND SOgr__includes=true AND SSog__tag=true AND SSsorg__description=true AND SOwsdbm__likes=true
	) tab4
 ON(tab2.v0=tab4.v0)
 JOIN    (SELECT sub AS v0 , obj AS v4 
	 FROM sorg__description$$4$$
	 
	 WHERE SSfoaf__homepage=true AND SOgr__includes=true AND SSog__tag=true AND SSsorg__contentSize=true AND SOwsdbm__likes=true
	) tab3
 ON(tab4.v0=tab3.v0)
 JOIN    (SELECT sub AS v1 , obj AS v5 
	 FROM sorg__url$$6$$ 
	 WHERE SOfoaf__homepage=true AND SSwsdbm__hits=true AND SSsorg__language=true
	) tab5
 ON(tab0.v1=tab5.v1)
 JOIN    (SELECT sub AS v1 , obj AS v6 
	 FROM wsdbm__hits$$7$$ 
	 WHERE SOfoaf__homepage=true AND SSsorg__url=true AND SSsorg__language=true
	) tab6
 ON(tab5.v1=tab6.v1)
 JOIN    (SELECT obj AS v0 , sub AS v2 
	 FROM gr__includes$$2$$ 
	 WHERE OSfoaf__homepage=true AND OSog__tag=true AND OSsorg__description=true AND OSsorg__contentSize=true
	) tab1
 ON(tab3.v0=tab1.v0)
 JOIN    (SELECT obj AS v0 , sub AS v7 
	 FROM wsdbm__likes$$9$$ 
	 WHERE OSfoaf__homepage=true AND OSog__tag=true AND OSsorg__description=true AND OSsorg__contentSize=true
	) tab8
 ON(tab1.v0=tab8.v0)


++++++Tables Statistic
sorg__url$$6$$	1	VP	sorg__url
	VP	<sorg__url>	500000
	SO	<sorg__url><foaf__homepage>	497821	1.0
	SS	<sorg__url><wsdbm__hits>	500000	1.0
	SS	<sorg__url><sorg__language>	500000	1.0
------
sorg__contentSize$$5$$	1	VP	sorg__contentSize
	VP	<sorg__contentSize>	249962
	SS	<sorg__contentSize><foaf__homepage>	62755	0.25
	SO	<sorg__contentSize><gr__includes>	243170	0.97
	SS	<sorg__contentSize><og__tag>	149736	0.6
	SS	<sorg__contentSize><sorg__description>	150300	0.6
	SO	<sorg__contentSize><wsdbm__likes>	236480	0.95
------
wsdbm__likes$$9$$	4	VP	wsdbm__likes
	VP	<wsdbm__likes>	11246476
	OS	<wsdbm__likes><foaf__homepage>	2612868	0.23
	OS	<wsdbm__likes><og__tag>	7045281	0.63
	OS	<wsdbm__likes><sorg__description>	6798751	0.6
	OS	<wsdbm__likes><sorg__contentSize>	1146319	0.1
------
og__tag$$3$$	4	VP	og__tag
	VP	<og__tag>	14987949
	SS	<og__tag><foaf__homepage>	3756781	0.25
	SO	<og__tag><gr__includes>	14578970	0.97
	SS	<og__tag><sorg__description>	9014205	0.6
	SS	<og__tag><sorg__contentSize>	1502548	0.1
	SO	<og__tag><wsdbm__likes>	14166117	0.95
------
sorg__language$$8$$	1	VP	sorg__language
	VP	<sorg__language>	641195
	SO	<sorg__language><foaf__homepage>	497821	0.78
	SS	<sorg__language><sorg__url>	500000	0.78
	SS	<sorg__language><wsdbm__hits>	500000	0.78
------
gr__includes$$2$$	4	VP	gr__includes
	VP	<gr__includes>	9000000
	OS	<gr__includes><foaf__homepage>	2254938	0.25
	OS	<gr__includes><og__tag>	5385932	0.6
	OS	<gr__includes><sorg__description>	5410279	0.6
	OS	<gr__includes><sorg__contentSize>	900806	0.1
------
wsdbm__hits$$7$$	1	VP	wsdbm__hits
	VP	<wsdbm__hits>	500000
	SO	<wsdbm__hits><foaf__homepage>	497821	1.0
	SS	<wsdbm__hits><sorg__url>	500000	1.0
	SS	<wsdbm__hits><sorg__language>	500000	1.0
------
sorg__description$$4$$	4	VP	sorg__description
	VP	<sorg__description>	1502748
	SS	<sorg__description><foaf__homepage>	376154	0.25
	SO	<sorg__description><gr__includes>	1462257	0.97
	SS	<sorg__description><og__tag>	899227	0.6
	SS	<sorg__description><sorg__contentSize>	150300	0.1
	SO	<sorg__description><wsdbm__likes>	1419870	0.94
------
foaf__homepage$$1$$	4	VP	foaf__homepage
	VP	<foaf__homepage>	1118496
	SO	<foaf__homepage><gr__includes>	609172	0.54
	SS	<foaf__homepage><og__tag>	374866	0.34
	SS	<foaf__homepage><sorg__description>	376154	0.34
	SS	<foaf__homepage><sorg__contentSize>	62755	0.06
	OS	<foaf__homepage><sorg__url>	1118496	1.0
	OS	<foaf__homepage><wsdbm__hits>	1118496	1.0
	OS	<foaf__homepage><sorg__language>	1118496	1.0
	SO	<foaf__homepage><wsdbm__likes>	591825	0.53
------
