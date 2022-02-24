
source ~/cluster1/delta_configs/env.delta

#create topic auto_insurance_claims
#confluent kafka topic create auto_insurance_claims

#you'll need a ksqlDB app to run the ksql code
#confluent  ksql app create claim_formatter
#confluent  api-key create --resource

#run ksql in claim-formatter.ksql

#upload the connector configuration
curl -X POST http://localhost:8083/connectors \
  -H 'Content-Type:application/json' \
  -H 'Accept:application/json' \
  -d @neo4j-sink.json

#wait a bit
curl -X GET http://localhost:8083/connectors/Neo4jSinkConnector/status | jq

exit


#open the Neo4j browser
http://localhost:7474/browser/

#cypher queries
MATCH (a:Adjuster)-[r:ADJUSTED]->(c:Claim)<-[PAID_BY]-(p:Payee)
RETURN a.name, count(r) as count, p.name
ORDER BY count DESC

MATCH (n:Adjuster)-[r:ADJUSTED]->(:Claim)
RETURN n.name, count(r) as count
ORDER BY count DESC

MATCH (a:Adjuster{name:'Nebula'})-[r:ADJUSTED]->(c:Claim)<-[PAID_BY]-(p:Payee)
RETURN p.name, count(r) as count
ORDER BY count DESC
