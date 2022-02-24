#!/bin/bash -x 

#source ~/demo/cluster0/
. /home/ubuntu/demo/cluster0/delta_configs/env.delta
kcat_opt="-b ${BOOTSTRAP_SERVERS}  -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN   -X sasl.username=${CLOUD_KEY} -X sasl.password=${CLOUD_SECRET} -X api.version.request=true"
kcat="docker run  -i --network=host edenhill/kcat:1.7.1 kcat"

#$kcat  -L -b ${BOOTSTRAP_SERVERS}  -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN   -X sasl.username=${CLOUD_KEY} -X sasl.password=${CLOUD_SECRET}  -X api.version.request=true


#cat ../data/patients.json | $kcat -t PATIENTS_STREAM $kcat_opt


kafka-producer-perf-test \
    --topic CLAIMS_STREAM \
    --throughput 1 \
    --producer.config  ktool_cc.config \
    --payload-file ../data/fhir_claims.json \
    --num-records 100000
