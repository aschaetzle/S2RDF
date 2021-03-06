SELECT tab0.v1 AS v1 , tab1.v0 AS v0 , tab6.v7 AS v7 , tab4.v5 AS v5 , tab3.v4 AS v4 , tab5.v6 AS v6 , tab2.v3 AS v3 , tab8.v9 AS v9 , tab7.v8 AS v8 
 FROM    (SELECT obj AS v0 
	 FROM gr__offers$$2$$ 
	 WHERE sub = 'wsdbm:Retailer44580'
	) tab1
 JOIN    (SELECT sub AS v0 , obj AS v9 
	 FROM sorg__priceValidUntil$$9$$
	
	) tab8
 ON(tab1.v0=tab8.v0)
 JOIN    (SELECT sub AS v0 , obj AS v5 
	 FROM gr__validFrom$$5$$
	
	) tab4
 ON(tab8.v0=tab4.v0)
 JOIN    (SELECT sub AS v0 , obj AS v6 
	 FROM gr__validThrough$$6$$
	
	) tab5
 ON(tab4.v0=tab5.v0)
 JOIN    (SELECT obj AS v1 , sub AS v0 
	 FROM gr__includes$$1$$
	) tab0
 ON(tab5.v0=tab0.v0)
 JOIN    (SELECT sub AS v0 , obj AS v4 
	 FROM gr__serialNumber$$4$$
	
	) tab3
 ON(tab0.v0=tab3.v0)
 JOIN    (SELECT sub AS v0 , obj AS v7 
	 FROM sorg__eligibleQuantity$$7$$
	
	) tab6
 ON(tab3.v0=tab6.v0)
 JOIN    (SELECT sub AS v0 , obj AS v8 
	 FROM sorg__eligibleRegion$$8$$
	
	) tab7
 ON(tab6.v0=tab7.v0)
 JOIN    (SELECT sub AS v0 , obj AS v3 
	 FROM gr__price$$3$$
	) tab2
 ON(tab7.v0=tab2.v0)


++++++Tables Statistic
gr__validThrough$$6$$	0	VP	gr__validThrough/
	VP	<gr__validThrough>	3602004
------
gr__includes$$1$$	0	VP	gr__includes/
	VP	<gr__includes>	9000000
------
sorg__priceValidUntil$$9$$	0	VP	sorg__priceValidUntil/
	VP	<sorg__priceValidUntil>	1801266
------
gr__offers$$2$$	0	VP	gr__offers/
	VP	<gr__offers>	14156906
------
sorg__eligibleQuantity$$7$$	0	VP	sorg__eligibleQuantity/
	VP	<sorg__eligibleQuantity>	9000000
------
sorg__eligibleRegion$$8$$	0	VP	sorg__eligibleRegion/
	VP	<sorg__eligibleRegion>	22527455
------
gr__validFrom$$5$$	0	VP	gr__validFrom/
	VP	<gr__validFrom>	3595844
------
gr__price$$3$$	0	VP	gr__price/
	VP	<gr__price>	24000000
------
gr__serialNumber$$4$$	0	VP	gr__serialNumber/
	VP	<gr__serialNumber>	9000000
------
