#!/bin/bash

########################################################
#
# NAME: CoMa into a Container
#
# Description:
#     Program developed to help the students with their project
# Version: 0.2
# Author: Miguel Gomez Simon
# Date: 24-11-2015
#
#######################################################

function startContainers(){

  docker restart gmond0 gmond1 gmond2 gmond3 hsflowHOSTest gmetadgwebnetwork

  IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" gmetadgwebnetwork)
  PORT=$(docker inspect gmetadgwebnetwork | jq '.[] | .NetworkSettings.Ports | .[] | .[] | .HostPort')

  echo " gweb available in address $IP:$PORT"

  docker exec gmetadgwebnetwork home/start-services-apache-gmetad.sh
  docker exec hsflowHOSTest /etc/init.d/hsflowd restart
  docker exec gmond0 gmond
  docker exec gmond1 gmond
  docker exec gmond2 gmond
  docker exec gmond3 gmond

}

startContainers
