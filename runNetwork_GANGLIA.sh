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


######### CREATE CONTAINER HOST sFLOW #################
#
# Creates a container that will send the metrics to the gmond0
#
#############################################
function createHostsFlowContainer(){

docker run -t -d --volume=/proc:/procHost:ro --name hsflowHOSTest miggom/course-hsflow:1.0 /bin/bash
docker network connect ltu.miguel.ganglia hsflowHOSTest
docker exec hsflowHOSTest /etc/init.d/hsflowd restart

}

######### CREATE Temporary Directory and RRD dir to bind #################
#
# Creates a temporary directory where the configuration files will be
# extracted from the container, modified with the correct settings and
# reintroduced into the containers.
#
#############################################
function createTemporaryDir(){
  echo "creating temporary  directory for configuration files"
  if [[ ! -d ./temp ]]; then
    mkdir ./temp;
  else
    echo "exists"
  fi
  echo "creating RRD directory to bind with the container"

  if [[ ! -d ./rrdBack ]]; then
    mkdir ./rrdBack;
    mkdir ./rrdBack/rrds
  else
    echo "exists"
  fi
}



######### CREATE CONTAINER GANGLIA #################
#
# $1 number of containers to CREATE
# $2 name of the containers
#
#
#############################################
function createContainers(){

  NAME=gmond
  NAME_NET="ltu.miguel.ganglia"
  NUM=$1
  if [ $# = 0 ]
  then
        NUM=4
  fi
  if [ "$#" = 2 ]
  then
        NUM=$1
        NAME=$2
        NAME_NET="ltu.miguel.ganglia"
  fi

  whileCounter=0

  while [[ whileCounter -lt NUM ]]; do
    NAME2=$NAME$whileCounter
    docker run -t -d --name=$NAME2 -p 8649/udp --hostname=$NAME2 miggom/course-gmond:1.0 /bin/bash
    docker network connect $NAME_NET $NAME2
    docker exec $NAME2 gmond
    echo "$NAME2.$NAME_NET" >> ./temp/net.txt
   ((whileCounter++))
  done

  #Creates the gmetad
  docker run -t -d -p 80 --name=gmetadgwebnetwork --hostname=gmetadgwebnetwork miggom/course-gmetad:1.01 /bin/bash
  docker network connect $NAME_NET gmetadgwebnetwork
  echo "Starting gmetad and gweb"
  docker exec gmetadgwebnetwork home/start-services-apache-gmetad.sh
  echo "done"

}

#Create Temporary directory
createTemporaryDir

# Execute Create Container
createContainers $1 $2

IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" gmetadgwebnetwork)
PORT=$(docker inspect gmetadgwebnetwork | jq '.[] | .NetworkSettings.Ports | .[] | .[] | .HostPort')

echo " gweb available in address $IP:$PORT"

echo $IP >> ./temp/net.txt

echo "Initiating hsflow ...."
createHostsFlowContainer $1
echo ""
echo "    +++++++        ++++++++++++     ++++++     +++   +++++++++++"
echo "    ++++++++++     ++++++++++++     +++++++    +++   +++++++++++"
echo "    +++    +++     +++      +++     +++ ++++   +++   +++           "
echo "    +++    +++     +++      +++     +++  ++++  +++   ++++++++      "
echo "    +++    +++     +++      +++     +++    +++ +++   +++           "
echo "    ++++++++++     ++++++++++++     +++     ++++++   +++++++++++"
echo "    +++++++        ++++++++++++     +++      +++++   +++++++++++"
echo
