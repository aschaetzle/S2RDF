# S2RDF

S2RDF (SPARQL on Spark for RDF) is a SPARQL query processor for Hadoop based on Spark SQL. It uses the relational interface of Spark for query execution and comes with a novel partitioning schema for RDF called ExtVP (Extended Vertical Partitioning) that is an extension of the Vertical Partitioning (VP) schema introduced by Abadi et al. ExtVP enables to exclude unnecessary data from query processing by taking into account the possible relations between tables in VP.

http://dbis.informatik.uni-freiburg.de/forschung/projekte/DiPoS/S2RDF.html
