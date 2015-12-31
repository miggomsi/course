#!/bin/bash

########################################################
#
# NAME: Monitoring into a Container
#
# Description:
#     Program developed to help the students with their project
# Version: 0.2
# Author: Miguel Gomez Simon
# Date: 24-11-2015
#
#######################################################

######### STOP CONTAINERS #################
#
# This method stops the containers running, gmond and gmetads
# arg: number of containers to stop
#############################################
function stopContainers(){

  docker exec gmetadgwebnetwork /home/stop-services-apache-gmetad.sh
  docker stop gmond0 gmond1 gmond2 gmond3 hsflowHOSTest gmetadgwebnetwork
}

stopContainers
