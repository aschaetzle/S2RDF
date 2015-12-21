SELECT tab0.v1 AS v1 , tab6.v7 AS v7 , tab4.v5 AS v5 , tab5.v6 AS v6 , tab3.v4 AS v4 , tab2.v3 AS v3 , tab1.v2 AS v2 
 FROM    (SELECT obj AS v1 
	 FROM wsdbm__follows$$1$$
	 
	 WHERE sub = 'wsdbm:User5427029' AND OSwsdbm__likes=true
	) tab0
 JOIN    (SELECT sub AS v1 , obj AS v2 
	 FROM wsdbm__likes$$2$$ 
	 WHERE SOwsdbm__follows=true AND OSrev__hasReview=true
	) tab1
 ON(tab0.v1=tab1.v1)
 JOIN    (SELECT obj AS v3 , sub AS v2 
	 FROM rev__hasReview$$3$$
	 
	 WHERE SOwsdbm__likes=true AND OSrev__reviewer=true
	) tab2
 ON(tab1.v2=tab2.v2)
 JOIN    (SELECT obj AS v4 , sub AS v3 
	 FROM rev__reviewer$$4$$
	 
	 WHERE SOrev__hasReview=true AND OSwsdbm__friendOf=true
	) tab3
 ON(tab2.v3=tab3.v3)
 JOIN    (SELECT obj AS v5 , sub AS v4 
	 FROM wsdbm__friendOf$$5$$
	 
	 WHERE SOrev__reviewer=true AND OSwsdbm__makesPurchase=true
	) tab4
 ON(tab3.v4=tab4.v4)
 JOIN    (SELECT sub AS v5 , obj AS v6 
	 FROM wsdbm__makesPurchase$$6$$
	 
	 WHERE SOwsdbm__friendOf=true AND OSwsdbm__purchaseFor=true
	) tab5
 ON(tab4.v5=tab5.v5)
 JOIN    (SELECT obj AS v7 , sub AS v6 
	 FROM wsdbm__purchaseFor$$7$$
	 
	 WHERE SOwsdbm__makesPurchase=true
	) tab6
 ON(tab5.v6=tab6.v6)


++++++Tables Statistic
wsdbm__makesPurchase$$6$$	0	VP	wsdbm__makesPurchase
	VP	<wsdbm__makesPurchase>	14999930
	SO	<wsdbm__makesPurchase><wsdbm__friendOf>	14999930	1.0
	OS	<wsdbm__makesPurchase><wsdbm__purchaseFor>	14999930	1.0
------
wsdbm__likes$$2$$	2	VP	wsdbm__likes
	VP	<wsdbm__likes>	11246476
	SO	<wsdbm__likes><wsdbm__follows>	10131513	0.9
	OS	<wsdbm__likes><rev__hasReview>	2148995	0.19
------
wsdbm__purchaseFor$$7$$	1	VP	wsdbm__purchaseFor
	VP	<wsdbm__purchaseFor>	15000000
	SO	<wsdbm__purchaseFor><wsdbm__makesPurchase>	14999930	1.0
------
rev__reviewer$$4$$	2	VP	rev__reviewer
	VP	<rev__reviewer>	15000000
	SO	<rev__reviewer><rev__hasReview>	14789439	0.99
	OS	<rev__reviewer><wsdbm__friendOf>	5991501	0.4
------
rev__hasReview$$3$$	1	VP	rev__hasReview
	VP	<rev__hasReview>	14789439
	SO	<rev__hasReview><wsdbm__likes>	13979801	0.95
	OS	<rev__hasReview><rev__reviewer>	14789439	1.0
------
wsdbm__follows$$1$$	1	VP	wsdbm__follows
	VP	<wsdbm__follows>	327487530
	OS	<wsdbm__follows><wsdbm__likes>	77832476	0.24
------
wsdbm__friendOf$$5$$	2	VP	wsdbm__friendOf
	VP	<wsdbm__friendOf>	449969341
	SO	<wsdbm__friendOf><rev__reviewer>	139006924	0.31
	OS	<wsdbm__friendOf><wsdbm__makesPurchase>	71070457	0.16
------
