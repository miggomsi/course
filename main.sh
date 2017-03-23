#!/bin/bash
###### MAIN SCRIPT ######

function main(){

USER=$(whoami)
PID=""

  if [[ $# = 0 ]]; then
    echo " Not arguments main {null,run,stop,start} {start,fix}" && exit 1
  fi

  if [[ $# = 2 ]]; then

      case "$1" in
      null)
      ;;
      run)
      echo "Start Running the infraestructure from scratch"
      gnome-terminal -e "bash -c \"docker daemon -H tcp://127.0.0.1:6666 -H unix:///var/run/docker.sock; exec bash \"" &> /dev/null &
      PID=$!
      echo " The PID of gnome-terminal is " $PID
      sleep 3
      ./runNetwork_GANGLIA.sh
      echo " Starting coma miguel module"
      ./runComa.sh run
      echo "Storing server pid in ./temp/net.txt: $PID"
      echo "Server PID: $PID" >> ./temp/net.txt


      # Change permission of the folders
      chmod -R 777 ./rrdBack/
      chmod -R 666 ./temp/*
        ;;
      stop)
      ./stopNetwork_GANGLIA.sh
        ;;
      start)
      ./startNetwork_GANGLIA.sh
      ;;
      destroy)
      PID=$(grep -o '[^\s.a-zA-Z:]\{5\}$' ./temp/net.txt)
      ./destroyNetwork_GANGLIA.sh
      sleep 1
      ./runComa.sh killMe
      sleep 1
      echo "Killing the server "
      kill -SIGTERM $PID
      echo "Restarting docker daemon"
      sudo service docker restart
      ;;
    esac

  fi

}
main $1 $2
