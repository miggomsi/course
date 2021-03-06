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
# This method stops the containers running
# arg: number of containers to stop
#############################################
function stopContainers(){
  stop=$1
  if [ $# = 0 ]
  then
        stop=4
  fi

  i=0
  docker stop gmetadgwebnetwork
  echo "gmetad stopped"
  while [[ $i -lt $stop ]]; do
    #statements
    docker stop gmond$i
    ((i++))
  done
  echo "stoping host sflow ..."
  docker stop hsflowHOSTest
  echo "done :)"
}
######### DESTROY CONTAINERS #################
#
# After stopping the number of containers it would be destroyed
# arg: number of containers to destroy
#
#############################################
function destroyContainers(){

  stop=$1
  if [ $# = 0 ]
  then
        stop=4
  fi
  i=0

  docker rm  gmetadgwebnetwork
  echo "gmetad destroyed"
  while [[ $i -lt $stop ]]; do
    #statements
    docker rm  gmond$i
    ((i++))
  done

  echo "destroying host sflow ..."
  docker rm hsflowHOSTest
  rm ./temp/net.txt
  echo "done :D"

}
stopContainers $1
destroyContainers $1
