#!/bin/bash

source ~/cluster1/delta_configs/env.delta

kafka-cluster-links --list --bootstrap-server localhost:9092
kafka-cluster cluster-id --bootstrap-server localhost:9092

kafka-cluster-links --bootstrap-server localhost:9092 \
      --create --link from-cloud-link \
      --config-file java.config \
      --cluster-id lkc-12r65v

kafka-mirrors --create \
	--bootstrap-server localhost:9092 \
        --link from-cloud-link \
	--mirror-topic auto-insurance-claims-avro

