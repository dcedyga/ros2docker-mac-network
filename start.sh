#!/bin/bash

scriptDir=`dirname "$0"`
scriptBasename=`basename "$0"`
echo "The script you are running has basename $scriptBasename, dirname $scriptDir"
echo "The present working directory is `pwd`"

# openVPN and docker-mac-network
docker network create --subnet=172.25.0.0/16 docker-mac-network_default
docker-compose -f $scriptDir/docker-mac-network/docker-compose.yml up -d
# openVPN comment comp-lzo fix
FILE=$scriptDir/docker-mac-network/config/openvpn.conf
echo $FILE
if [ -f "$FILE" ]; then
  echo "$FILE exists"
  # check if comp-lzo is commented
  grep "#comp-lzo no" $FILE
  out=$(echo $?)
  echo "out:$out"
  if [ $out = 1 ]; then
    # config not being refreshed we need to fix it
    sed 's/^comp-lzo no/#comp-lzo no/' $FILE > $FILE.bak
    mv $FILE.bak $FILE
    #restart docker-compose
    docker-compose -f $scriptDir/docker-mac-network/docker-compose.yml down
    docker-compose -f $scriptDir/docker-mac-network/docker-compose.yml up -d
  fi
fi
# start ros galactic fast-dds discovery server 
docker-compose -f $scriptDir/docker-compose.yml up -d
echo $(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ros2docker-mac-network_ros2-fast-dds-discovery-server_1)

# ros galactic super-client setup

# restart ros deamon
ros2 daemon stop
ros2 daemon start