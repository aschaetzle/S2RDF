SELECT tab0.v1 AS v1 , tab0.v0 AS v0 , tab6.v7 AS v7 , tab4.v5 AS v5 , tab5.v6 AS v6 , tab3.v4 AS v4 , tab2.v3 AS v3 , tab7.v8 AS v8 , tab1.v2 AS v2 
 FROM    (SELECT obj AS v1 , sub AS v0 
	 FROM sorg__caption$$1$$
	 
	 WHERE SSsorg__text=true AND SSsorg__contentRating=true AND SSrev__hasReview=true
	) tab0
 JOIN    (SELECT sub AS v0 , obj AS v2 
	 FROM sorg__text$$2$$ 
	 WHERE SSsorg__caption=true AND SSsorg__contentRating=true AND SSrev__hasReview=true
	) tab1
 ON(tab0.v0=tab1.v0)
 JOIN    (SELECT sub AS v0 , obj AS v3 
	 FROM sorg__contentRating$$3$$
	 
	 WHERE SSsorg__caption=true AND SSsorg__text=true AND SSrev__hasReview=true
	) tab2
 ON(tab1.v0=tab2.v0)
 JOIN    (SELECT sub AS v0 , obj AS v4 
	 FROM rev__hasReview$$4$$
	 
	 WHERE SSsorg__caption=true AND SSsorg__text=true AND SSsorg__contentRating=true AND OSrev__title=true AND OSrev__reviewer=true
	) tab3
 ON(tab2.v0=tab3.v0)
 JOIN    (SELECT obj AS v5 , sub AS v4 
	 FROM rev__title$$5$$ 
	 WHERE SOrev__hasReview=true AND SSrev__reviewer=true
	) tab4
 ON(tab3.v4=tab4.v4)
 JOIN    (SELECT obj AS v6 , sub AS v4 
	 FROM rev__reviewer$$6$$
	 
	 WHERE SOrev__hasReview=true AND SSrev__title=true
	) tab5
 ON(tab4.v4=tab5.v4)
 JOIN    (SELECT sub AS v7 , obj AS v6 
	 FROM sorg__actor$$7$$ 
	 WHERE SSsorg__language=true
	) tab6
 ON(tab5.v6=tab6.v6)
 JOIN    (SELECT sub AS v7 , obj AS v8 
	 FROM sorg__language$$8$$
	 
	 WHERE SSsorg__actor=true
	) tab7
 ON(tab6.v7=tab7.v7)


++++++Tables Statistic
sorg__actor$$7$$	1	VP	sorg__actor
	VP	<sorg__actor>	1668
	SS	<sorg__actor><sorg__language>	456	0.27
------
rev__reviewer$$6$$	2	VP	rev__reviewer
	VP	<rev__reviewer>	15000
	SO	<rev__reviewer><rev__hasReview>	14757	0.98
	SS	<rev__reviewer><rev__title>	4553	0.3
------
sorg__contentRating$$3$$	1	VP	sorg__contentRating
	VP	<sorg__contentRating>	749
	SS	<sorg__contentRating><sorg__caption>	68	0.09
	SS	<sorg__contentRating><sorg__text>	236	0.32
	SS	<sorg__contentRating><rev__hasReview>	136	0.18
------
sorg__language$$8$$	1	VP	sorg__language
	VP	<sorg__language>	655
	SS	<sorg__language><sorg__actor>	83	0.13
------
rev__hasReview$$4$$	1	VP	rev__hasReview
	VP	<rev__hasReview>	14757
	SS	<rev__hasReview><sorg__caption>	1466	0.1
	SS	<rev__hasReview><sorg__text>	4408	0.3
	SS	<rev__hasReview><sorg__contentRating>	4049	0.27
	OS	<rev__hasReview><rev__title>	4486	0.3
	OS	<rev__hasReview><rev__reviewer>	14757	1.0
------
sorg__caption$$1$$	3	VP	sorg__caption
	VP	<sorg__caption>	225
	SS	<sorg__caption><sorg__text>	61	0.27
	SS	<sorg__caption><sorg__contentRating>	68	0.3
	SS	<sorg__caption><rev__hasReview>	48	0.21
------
sorg__text$$2$$	1	VP	sorg__text
	VP	<sorg__text>	746
	SS	<sorg__text><sorg__caption>	61	0.08
	SS	<sorg__text><sorg__contentRating>	236	0.32
	SS	<sorg__text><rev__hasReview>	149	0.2
------
rev__title$$5$$	1	VP	rev__title
	VP	<rev__title>	4553
	SO	<rev__title><rev__hasReview>	4486	0.99
	SS	<rev__title><rev__reviewer>	4553	1.0
------
