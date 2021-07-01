#!/bin/bash

scriptDir=`dirname "$0"`
# stop ros galactic fast-dds discovery server 
docker-compose -f $scriptDir/docker-compose.yml down
docker-compose -f $scriptDir/docker-mac-network/docker-compose.yml down
