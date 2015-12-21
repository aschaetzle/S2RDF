SELECT tab1.v1 AS v1 , tab0.v0 AS v0 , tab5.v5 AS v5 , tab6.v7 AS v7 , tab4.v4 AS v4 , tab6.v6 AS v6 , tab3.v3 AS v3 , tab8.v9 AS v9 , tab2.v2 AS v2 , tab7.v8 AS v8 , tab9.v10 AS v10 
 FROM    (SELECT obj AS v7 , sub AS v6 
	 FROM sorg__author$$7$$ 
	 WHERE SOwsdbm__likes=true AND OSwsdbm__follows=true
	) tab6
 JOIN    (SELECT sub AS v5 , obj AS v6 
	 FROM wsdbm__likes$$6$$ 
	 WHERE SOwsdbm__friendOf=true AND OSsorg__author=true
	) tab5
 ON(tab6.v6=tab5.v6)
 JOIN    (SELECT sub AS v7 , obj AS v8 
	 FROM wsdbm__follows$$8$$
	 
	 WHERE SOsorg__author=true AND OSfoaf__homepage=true
	) tab7
 ON(tab6.v7=tab7.v7)
 JOIN    (SELECT obj AS v9 , sub AS v8 
	 FROM foaf__homepage$$9$$
	 
	 WHERE SOwsdbm__follows=true AND OSsorg__language=true
	) tab8
 ON(tab7.v8=tab8.v8)
 JOIN    (SELECT sub AS v9 , obj AS v10 
	 FROM sorg__language$$10$$
	 
	 WHERE SOfoaf__homepage=true
	) tab9
 ON(tab8.v9=tab9.v9)
 JOIN    (SELECT obj AS v5 , sub AS v4 
	 FROM wsdbm__friendOf$$5$$
	 
	 WHERE SOrev__reviewer=true AND OSwsdbm__likes=true
	) tab4
 ON(tab5.v5=tab4.v5)
 JOIN    (SELECT obj AS v4 , sub AS v3 
	 FROM rev__reviewer$$4$$
	 
	 WHERE SOrev__hasReview=true AND OSwsdbm__friendOf=true
	) tab3
 ON(tab4.v4=tab3.v4)
 JOIN    (SELECT obj AS v3 , sub AS v2 
	 FROM rev__hasReview$$3$$
	 
	 WHERE SOgr__includes=true AND OSrev__reviewer=true
	) tab2
 ON(tab3.v3=tab2.v3)
 JOIN    (SELECT sub AS v1 , obj AS v2 
	 FROM gr__includes$$2$$ 
	 WHERE SOgr__offers=true AND OSrev__hasReview=true
	) tab1
 ON(tab2.v2=tab1.v2)
 JOIN    (SELECT obj AS v1 , sub AS v0 
	 FROM gr__offers$$1$$ 
	 WHERE OSgr__includes=true
	) tab0
 ON(tab1.v1=tab0.v1)


++++++Tables Statistic
wsdbm__likes$$6$$	2	VP	wsdbm__likes
	VP	<wsdbm__likes>	11256
	SO	<wsdbm__likes><wsdbm__friendOf>	11256	1.0
	OS	<wsdbm__likes><sorg__author>	980	0.09
------
sorg__language$$10$$	1	VP	sorg__language
	VP	<sorg__language>	655
	SO	<sorg__language><foaf__homepage>	493	0.75
------
gr__offers$$1$$	0	VP	gr__offers
	VP	<gr__offers>	14179
	OS	<gr__offers><gr__includes>	14179	1.0
------
sorg__author$$7$$	2	VP	sorg__author
	VP	<sorg__author>	367
	SO	<sorg__author><wsdbm__likes>	347	0.95
	OS	<sorg__author><wsdbm__follows>	279	0.76
------
foaf__homepage$$9$$	1	VP	foaf__homepage
	VP	<foaf__homepage>	1068
	SO	<foaf__homepage><wsdbm__follows>	441	0.41
	OS	<foaf__homepage><sorg__language>	1068	1.0
------
rev__reviewer$$4$$	2	VP	rev__reviewer
	VP	<rev__reviewer>	15000
	SO	<rev__reviewer><rev__hasReview>	14757	0.98
	OS	<rev__reviewer><wsdbm__friendOf>	5835	0.39
------
gr__includes$$2$$	2	VP	gr__includes
	VP	<gr__includes>	9000
	SO	<gr__includes><gr__offers>	4722	0.52
	OS	<gr__includes><rev__hasReview>	1837	0.2
------
rev__hasReview$$3$$	1	VP	rev__hasReview
	VP	<rev__hasReview>	14757
	SO	<rev__hasReview><gr__includes>	14349	0.97
	OS	<rev__hasReview><rev__reviewer>	14757	1.0
------
wsdbm__follows$$8$$	1	VP	wsdbm__follows
	VP	<wsdbm__follows>	330403
	SO	<wsdbm__follows><sorg__author>	11555	0.03
	OS	<wsdbm__follows><foaf__homepage>	14952	0.05
------
wsdbm__friendOf$$5$$	2	VP	wsdbm__friendOf
	VP	<wsdbm__friendOf>	448135
	SO	<wsdbm__friendOf><rev__reviewer>	133496	0.3
	OS	<wsdbm__friendOf><wsdbm__likes>	106881	0.24
------
