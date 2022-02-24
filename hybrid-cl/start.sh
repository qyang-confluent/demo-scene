#!/bin/bash

docker-compose down
source ~/cluster1/delta_configs/env.delta
docker-compose up -d 

