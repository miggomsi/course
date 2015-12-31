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


#### COPY THE DATABASE OF GANGLIA ####
######### CREATE FOLDER #################
#
# $1 name of the version folder
#
#
#############################################
function copydb(){
  docker cp gmetadgwebnetwork:/var/lib/ganglia/rrds ./rrdBack/rrds/$1
}

function createFolder(){

  NAME=$1
  if [ $# = 0 ]
  then
        echo " You need to put a name to the folder for creating the copy that will be stored in t ./rrdBack/rrds"
        exit 0
  fi

  if [[ ! -d ./rrdBack ]]; then
    mkdir ./rrdBack;
  else
    echo "exists rrdBack"
    if [[ ! -d ./rrdBack/rrds ]]; then
        mkdir ./rrdBack/rrds
    else
      echo "exists rrdBack/rrds"
      if [[ ! -d ./rrdBack/rrds/$NAME ]]; then
        mkdir ./rrdBack/rrds/$NAME
      else
        echo " The folder $NAME exists please insert another name"
        exit 0
      fi
    fi
  fi

  copydb $NAME

}

######### COPY METHOD #################
#
# $1 name of the version folder to copy into
#
#
########################################

createFolder $1
