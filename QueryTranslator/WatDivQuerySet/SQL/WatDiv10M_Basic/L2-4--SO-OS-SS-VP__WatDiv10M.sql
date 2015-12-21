SELECT tab0.v1 AS v1 , tab2.v2 AS v2 
 FROM    (SELECT obj AS v1 
	 FROM gn__parentCountry$$1$$
	 
	 WHERE sub = 'wsdbm:City42'
	) tab0
 JOIN    (SELECT obj AS v1 , sub AS v2 
	 FROM sorg__nationality$$3$$
	 
	 WHERE SSwsdbm__likes=true
	) tab2
 ON(tab0.v1=tab2.v1)
 JOIN    (SELECT sub AS v2 
	 FROM wsdbm__likes$$2$$ 
	 WHERE obj = 'wsdbm:Product0' AND SSsorg__nationality=true
	) tab1
 ON(tab2.v2=tab1.v2)


++++++Tables Statistic
gn__parentCountry$$1$$	0	VP	gn__parentCountry
	VP	<gn__parentCountry>	240
------
wsdbm__likes$$2$$	1	VP	wsdbm__likes
	VP	<wsdbm__likes>	112401
	SS	<wsdbm__likes><sorg__nationality>	22117	0.2
------
sorg__nationality$$3$$	1	VP	sorg__nationality
	VP	<sorg__nationality>	19924
	SS	<sorg__nationality><wsdbm__likes>	4799	0.24
------
