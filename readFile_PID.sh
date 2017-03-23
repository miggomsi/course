#!/bin/bash
#############################################
#
#
#       This class reads from a file.
#     The input file is located ./temp/net.txt
#     Date 2/3/16
#
#
#############################################

PID=""

##################  readFILE ###########################
#
#
# @param: It gets as input parameter a file
# @returns: It returns nothing but update the PID global
#
#############################################
function readFILE(){
  echo grep
  LINE_PID=$(grep 'Server PID: ' $1)
  echo "Print LINE_PID: " $LINE_PID
  PID=$(grep '[0-9]' $LINE_PID)
  echo "PID is : $PID"

  echo "grep try 2"
  #PID2=$(grep -o 'Server PID: [^a-zA-Z]*' $1)
  #VALIDA ONE
  PID2=$(grep -o '[0-9]\{5\}$' $1)
  echo "PID2 is :$PID2"
}


##################  readFILE ###########################
#
#
# @param: It gets as input parameter a file
# @returns: It returns nothing but update the PID global
#
#############################################
function readSEDfile(){
  echo "sed"
  sed -n -e '/Server PID: /,$p' $1
}
readFILE $1
readSEDfile $1
