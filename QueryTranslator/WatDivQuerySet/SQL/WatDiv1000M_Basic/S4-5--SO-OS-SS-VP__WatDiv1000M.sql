SELECT tab3.v0 AS v0 , tab2.v3 AS v3 , tab1.v2 AS v2 
 FROM    (SELECT sub AS v0 
	 FROM sorg__nationality$$4$$
	 
	 WHERE obj = 'wsdbm:Country1' AND SSfoaf__age=true AND SSfoaf__familyName=true AND SOmo__artist=true
	) tab3
 JOIN    (SELECT sub AS v0 
	 FROM foaf__age$$1$$ 
	 WHERE obj = 'wsdbm:AgeGroup4' AND SSfoaf__familyName=true AND SOmo__artist=true AND SSsorg__nationality=true
	) tab0
 ON(tab3.v0=tab0.v0)
 JOIN    (SELECT obj AS v0 , sub AS v3 
	 FROM mo__artist$$3$$ 
	 WHERE OSfoaf__age=true AND OSfoaf__familyName=true AND OSsorg__nationality=true
	) tab2
 ON(tab0.v0=tab2.v0)
 JOIN    (SELECT sub AS v0 , obj AS v2 
	 FROM foaf__familyName$$2$$
	 
	 WHERE SSfoaf__age=true AND SOmo__artist=true AND SSsorg__nationality=true
	) tab1
 ON(tab2.v0=tab1.v0)


++++++Tables Statistic
foaf__familyName$$2$$	2	VP	foaf__familyName
	VP	<foaf__familyName>	7001593
	SS	<foaf__familyName><foaf__age>	3499830	0.5
	SO	<foaf__familyName><mo__artist>	36210	0.01
	SS	<foaf__familyName><sorg__nationality>	1400689	0.2
------
mo__artist$$3$$	3	VP	mo__artist
	VP	<mo__artist>	132709
	OS	<mo__artist><foaf__age>	66072	0.5
	OS	<mo__artist><foaf__familyName>	83975	0.63
	OS	<mo__artist><sorg__nationality>	29612	0.22
------
sorg__nationality$$4$$	3	VP	sorg__nationality
	VP	<sorg__nationality>	2000713
	SS	<sorg__nationality><foaf__age>	1001234	0.5
	SS	<sorg__nationality><foaf__familyName>	1400689	0.7
	SO	<sorg__nationality><mo__artist>	10448	0.01
------
foaf__age$$1$$	2	VP	foaf__age
	VP	<foaf__age>	4998434
	SS	<foaf__age><foaf__familyName>	3499830	0.7
	SO	<foaf__age><mo__artist>	25948	0.01
	SS	<foaf__age><sorg__nationality>	1001234	0.2
------
