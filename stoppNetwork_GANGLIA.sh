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


function stopContainers(){

  docker exec gmetadgwebnetwork /home/stop-services-apache-gmetad.sh
  docker stop gmond0 gmond1 gmond2 gmond3 hsflowHOSTest gmetadgwebnetwork
}

stopContainers
