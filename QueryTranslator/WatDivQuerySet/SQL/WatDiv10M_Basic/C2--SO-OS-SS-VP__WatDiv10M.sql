SELECT tab0.v1 AS v1 , tab1.v0 AS v0 , tab4.v5 AS v5 , tab7.v7 AS v7 , tab5.v6 AS v6 , tab6.v4 AS v4 , tab9.v9 AS v9 , tab3.v3 AS v3 , tab8.v8 AS v8 , tab2.v2 AS v2 
 FROM    (SELECT sub AS v2 
	 FROM sorg__eligibleRegion$$3$$
	 
	 WHERE obj = 'wsdbm:Country5' AND SOgr__offers=true AND SSgr__includes=true
	) tab2
 JOIN    (SELECT sub AS v0 , obj AS v2 
	 FROM gr__offers$$2$$ 
	 WHERE SSsorg__legalName=true AND OSsorg__eligibleRegion=true AND OSgr__includes=true
	) tab1
 ON(tab2.v2=tab1.v2)
 JOIN    (SELECT obj AS v1 , sub AS v0 
	 FROM sorg__legalName$$1$$
	 
	 WHERE SSgr__offers=true
	) tab0
 ON(tab1.v0=tab0.v0)
 JOIN    (SELECT obj AS v3 , sub AS v2 
	 FROM gr__includes$$4$$ 
	 WHERE SOgr__offers=true AND SSsorg__eligibleRegion=true AND OSrev__hasReview=true
	) tab3
 ON(tab1.v2=tab3.v2)
 JOIN    (SELECT sub AS v3 , obj AS v8 
	 FROM rev__hasReview$$9$$
	 
	 WHERE SOgr__includes=true AND SOwsdbm__purchaseFor=true AND OSrev__totalVotes=true
	) tab8
 ON(tab3.v3=tab8.v3)
 JOIN    (SELECT obj AS v9 , sub AS v8 
	 FROM rev__totalVotes$$10$$
	 
	 WHERE SOrev__hasReview=true
	) tab9
 ON(tab8.v8=tab9.v8)
 JOIN    (SELECT sub AS v7 , obj AS v3 
	 FROM wsdbm__purchaseFor$$8$$
	 
	 WHERE SOwsdbm__makesPurchase=true AND OSrev__hasReview=true
	) tab7
 ON(tab8.v3=tab7.v3)
 JOIN    (SELECT obj AS v7 , sub AS v4 
	 FROM wsdbm__makesPurchase$$7$$
	 
	 WHERE SSsorg__jobTitle=true AND SSfoaf__homepage=true AND OSwsdbm__purchaseFor=true
	) tab6
 ON(tab7.v7=tab6.v7)
 JOIN    (SELECT obj AS v5 , sub AS v4 
	 FROM sorg__jobTitle$$5$$
	 
	 WHERE SSfoaf__homepage=true AND SSwsdbm__makesPurchase=true
	) tab4
 ON(tab6.v4=tab4.v4)
 JOIN    (SELECT obj AS v6 , sub AS v4 
	 FROM foaf__homepage$$6$$
	 
	 WHERE SSsorg__jobTitle=true AND SSwsdbm__makesPurchase=true
	) tab5
 ON(tab4.v4=tab5.v4)


++++++Tables Statistic
gr__includes$$4$$	3	VP	gr__includes
	VP	<gr__includes>	90000
	SO	<gr__includes><gr__offers>	44841	0.5
	SS	<gr__includes><sorg__eligibleRegion>	44935	0.5
	OS	<gr__includes><rev__hasReview>	18580	0.21
------
foaf__homepage$$6$$	1	VP	foaf__homepage
	VP	<foaf__homepage>	11204
	SS	<foaf__homepage><sorg__jobTitle>	245	0.02
	SS	<foaf__homepage><wsdbm__makesPurchase>	766	0.07
------
rev__hasReview$$9$$	3	VP	rev__hasReview
	VP	<rev__hasReview>	149634
	SO	<rev__hasReview><gr__includes>	145435	0.97
	SO	<rev__hasReview><wsdbm__purchaseFor>	107006	0.72
	OS	<rev__hasReview><rev__totalVotes>	7545	0.05
------
gr__offers$$2$$	1	VP	gr__offers
	VP	<gr__offers>	119316
	SS	<gr__offers><sorg__legalName>	10533	0.09
	OS	<gr__offers><sorg__eligibleRegion>	58569	0.49
	OS	<gr__offers><gr__includes>	119316	1.0
------
sorg__legalName$$1$$	0	VP	sorg__legalName
	VP	<sorg__legalName>	108
	SS	<sorg__legalName><gr__offers>	108	1.0
------
wsdbm__purchaseFor$$8$$	2	VP	wsdbm__purchaseFor
	VP	<wsdbm__purchaseFor>	150000
	SO	<wsdbm__purchaseFor><wsdbm__makesPurchase>	149998	1.0
	OS	<wsdbm__purchaseFor><rev__hasReview>	33884	0.23
------
sorg__jobTitle$$5$$	1	VP	sorg__jobTitle
	VP	<sorg__jobTitle>	5008
	SS	<sorg__jobTitle><foaf__homepage>	245	0.05
	SS	<sorg__jobTitle><wsdbm__makesPurchase>	763	0.15
------
wsdbm__makesPurchase$$7$$	1	VP	wsdbm__makesPurchase
	VP	<wsdbm__makesPurchase>	149998
	SS	<wsdbm__makesPurchase><sorg__jobTitle>	7225	0.05
	SS	<wsdbm__makesPurchase><foaf__homepage>	7230	0.05
	OS	<wsdbm__makesPurchase><wsdbm__purchaseFor>	149998	1.0
------
rev__totalVotes$$10$$	1	VP	rev__totalVotes
	VP	<rev__totalVotes>	7554
	SO	<rev__totalVotes><rev__hasReview>	7545	1.0
------
sorg__eligibleRegion$$3$$	1	VP	sorg__eligibleRegion
	VP	<sorg__eligibleRegion>	183550
	SO	<sorg__eligibleRegion><gr__offers>	91392	0.5
	SS	<sorg__eligibleRegion><gr__includes>	183550	1.0
------
