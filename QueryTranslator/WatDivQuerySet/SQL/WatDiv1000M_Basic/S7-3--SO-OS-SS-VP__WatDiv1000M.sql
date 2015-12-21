SELECT tab0.v1 AS v1 , tab2.v0 AS v0 , tab1.v2 AS v2 
 FROM    (SELECT obj AS v0 
	 FROM wsdbm__likes$$3$$ 
	 WHERE sub = 'wsdbm:User2329730' AND OSrdf__type=true AND OSsorg__text=true
	) tab2
 JOIN    (SELECT sub AS v0 , obj AS v2 
	 FROM sorg__text$$2$$ 
	 WHERE SSrdf__type=true AND SOwsdbm__likes=true
	) tab1
 ON(tab2.v0=tab1.v0)
 JOIN    (SELECT obj AS v1 , sub AS v0 
	 FROM rdf__type$$1$$ 
	 WHERE SSsorg__text=true AND SOwsdbm__likes=true
	) tab0
 ON(tab1.v0=tab0.v0)


++++++Tables Statistic
wsdbm__likes$$3$$	2	VP	wsdbm__likes
	VP	<wsdbm__likes>	11246476
	OS	<wsdbm__likes><rdf__type>	11246476	1.0
	OS	<wsdbm__likes><sorg__text>	3276540	0.29
------
rdf__type$$1$$	1	VP	rdf__type
	VP	<rdf__type>	14800449
	SS	<rdf__type><sorg__text>	749948	0.05
	SO	<rdf__type><wsdbm__likes>	2362781	0.16
------
sorg__text$$2$$	2	VP	sorg__text
	VP	<sorg__text>	749948
	SS	<sorg__text><rdf__type>	749948	1.0
	SO	<sorg__text><wsdbm__likes>	708787	0.95
------
