SELECT tab3.v0 AS v0 , tab2.v3 AS v3 , tab1.v2 AS v2 
 FROM    (SELECT sub AS v0 
	 FROM sorg__language$$4$$
	 
	 WHERE obj = 'wsdbm:Language0' AND SSrdf__type=true AND SSsorg__description=true AND SSsorg__keywords=true
	) tab3
 JOIN    (SELECT sub AS v0 
	 FROM rdf__type$$1$$ 
	 WHERE obj = 'wsdbm:ProductCategory8' AND SSsorg__description=true AND SSsorg__keywords=true AND SSsorg__language=true
	) tab0
 ON(tab3.v0=tab0.v0)
 JOIN    (SELECT sub AS v0 , obj AS v3 
	 FROM sorg__keywords$$3$$
	 
	 WHERE SSrdf__type=true AND SSsorg__description=true AND SSsorg__language=true
	) tab2
 ON(tab0.v0=tab2.v0)
 JOIN    (SELECT sub AS v0 , obj AS v2 
	 FROM sorg__description$$2$$
	 
	 WHERE SSrdf__type=true AND SSsorg__keywords=true AND SSsorg__language=true
	) tab1
 ON(tab2.v0=tab1.v0)


++++++Tables Statistic
sorg__description$$2$$	3	VP	sorg__description
	VP	<sorg__description>	150228
	SS	<sorg__description><rdf__type>	150228	1.0
	SS	<sorg__description><sorg__keywords>	45005	0.3
	SS	<sorg__description><sorg__language>	3084	0.02
------
rdf__type$$1$$	3	VP	rdf__type
	VP	<rdf__type>	1480374
	SS	<rdf__type><sorg__description>	150228	0.1
	SS	<rdf__type><sorg__keywords>	75175	0.05
	SS	<rdf__type><sorg__language>	5140	0.0
------
sorg__keywords$$3$$	3	VP	sorg__keywords
	VP	<sorg__keywords>	75175
	SS	<sorg__keywords><rdf__type>	75175	1.0
	SS	<sorg__keywords><sorg__description>	45005	0.6
	SS	<sorg__keywords><sorg__language>	1579	0.02
------
sorg__language$$4$$	3	VP	sorg__language
	VP	<sorg__language>	63899
	SS	<sorg__language><rdf__type>	13899	0.22
	SS	<sorg__language><sorg__description>	8366	0.13
	SS	<sorg__language><sorg__keywords>	4318	0.07
------
