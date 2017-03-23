#!/bin/bash

########################################################
#
# NAME: CoMa into a Container
#
# Description:
#     Program developed to help the students with their project
#     Here putting CoMA into a container
# Version: 0.2.1
# Author: Miguel Gomez Simon
# Date: 12-02-2016
#
#######################################################





#### GLOBALS #####
NAME_NET="ltu.miguel.ganglia"
CONT_FROM="hsflowHOSTest"
CONT_TO="comaRemotAPI"

#Path file to copy
PATH_FROM="/etc/hsflowd.auto"
FILE_NAME="hsflowd.auto"


######### COPY CONTAINER FILE #################
#
# $1 File to copy.(location of the file). for example /etc/hsflowd.auto
# $2 container copy FROM
# $3 container copy TO
#
#############################################

function copyFromtoComa(){

  if [[ $# = 0 ]]; then
    echo " Not arguments copyFromtoComa {/location/file} {nameContainerFrom} {nameContainerTO}" && exit 1
  fi

  if [ "$#" = 3 ]
  then
        PATH_FILE=$1
        CONT_FROM=$2
        CONT_TO=$3

        #Copy the file from the contianer->host. Location ./temp/hsflowd.auto
        if [[ ! -d ./temp ]]; then
          mkdir ./temp;
        else
          if [[  -f ./temp/$FILE_NAME ]]; then
              rm $FILE_NAME
          else
            docker cp $CONT_FROM:$PATH_FROM ./temp
            docker cp ./temp/$FILE_NAME $CONT_TO:$PATH_FROM
	    # This line does not work: Added 26-06-16 echo "----hostsFlow config file transfered---"

            #DEV COMA container
            #docker cp ./temp/$FILE_NAME comaDEV:$PATH_FROM

          fi # copy hsflowd.auto
        fi # temp folder creation
  fi #arguments 3
}


######### CREATE CONTAINER COMA #################
#
# The first argument is either run or kill. It starts or stops the container
#
#
#############################################

function startComa(){
  #older versions that work
  #VERSION=2
  #current version of the coma images
  #- VERSION=5 has the original path in the dockerapi.sh ./gmetric.py
  #- VERSION= 6 has the original code. The changes are that dockerapi.sh has a path changed for /home/comacode/gmetric.sh
  #- VERSION=7 Is the same than version 6 but with logs
  #- VERSION=8 Is the same than version 7 but more logs

  VERSION=8

  if [[ $# = 0 ]]; then
    echo " Not arguments runComa.sh {run,killMe}" && exit 1
  fi
  if [ "$#" = 1 ]
  then
  case "$1" in
    run)
    docker run -it -d --name=comaRemotAPI --hostname=comaRA miggom/ganglia:coma0$VERSION /bin/bash
    docker network  connect $NAME_NET comaRemotAPI
    echo "Coping now to the Coma container the hsflowd File"
    copyFromtoComa $FILE_NAME $CONT_FROM $CONT_TO
    # This line does not work  Added 26-06-16 : echo " PATH HSFLOW FILE = $copyFromtoComa "
    echo "Starting Server to perform requests"
    docker exec comaRemotAPI /home/comaCode/dockerapi.sh
    ;;
    killMe)
    docker stop comaRemotAPI
    docker rm comaRemotAPI
  esac

  fi
}




startComa $1



#################### NOTES ###########################

# How to bind the socket with docker
# sudo /usr/bin/docker -H tcp://127.0.0.1:6666 -H unix:///var/run/docker.sock -d &

#######################################################
