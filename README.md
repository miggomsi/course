# course
This project that will be evolving was motivated by the CloudBerry Project at LTU, in which I participate and wrote a paper with some of the participants

http://www.scitepress.org/DigitalLibrary/PublicationsDetail.aspx?ID=mmpx5QPWYWI=&t=1

This is for the students that are taking the course in LTU


It is neccessary to have at least Docker 1.8 that contains Docker Network.

Before running any script you must create the network and install jq. Jq is used to get the IP address where ganglia will be running on.

  - sudo docker network create ltu.miguel.ganglia
  - sudo apt-get install jq

Execute it:

You have to do ( I will make the example with the runNetwork_GANGLIA.sh)

  - sudo runNetwork_GANGLIA.sh
  - runNetwork_GANGLIA.sh (this command you can use it if your user has been included in the docker group*)


* To include your user in the docker group
    sudo usermod -aG docker myUserName

runNetwork_GANGLIA.sh script creates the network and connects all the containers. 

  - 1 gmetad container with gweb
  - 1 gmond container that creates cluster1. This cluster will received the metrics from the host
  - 1 gmond container for redundancy
  - 2 gmond container for other cluster
  - 1 hostsflow agent container modified to get the metrics from the host.
   
  It also creates two folders in the folder where these scripts are stored:
    - temp: This folder will have a file with the gmond domain addresses and also with the IP address where gweb is running
    - rrdBack: This folder will contain bakcups of the rrdb done with the copy script explained below.

destroyNetwork_GANGLIA.sh

  Once the network has been created executing the script before, you can stop and destroy all the containers executing this script. This will remove the file created in the temp folder but not the backups stored in the rrdBack folder
  
stopNetwork_GANGLIA.sh

 This script allows you to stop the network without destrying it.
 
startNetwork_GANGLIA.sh

  This script allows you to restart the network once it has been stopped before
  
copyNetwork_GANGLIA.sh

  This file gets an input argument which will be the name of the folder where the database will be stored. This folder allways will be within the rrdBack folder
  
  EXTRA IN THIS BRANCH
  
  This is the version done for the students


	There are 2 images

		miggom/course-gmetad:1.01 This contains the gmetad gmond and the apache2
		miggom/course-gmond:1.0 This runs the gmond
		miggom/course-hsflow:1.0 This runs the hsflow


There are 4 gmonds 1 gmetad 1 hsflow taking the metrics from the host



Now the main.sh deployes and destroyes automatically the server.
There is a problem with the apache running in the image. The problem is that, for some reason it does not allow to run the PID
I need to fix this but is going to be a bit hard since there is not only solution although people have the same problem


I have two new files
		-startSERVERDOCKER.sh. This will start the server  (done in main)
		-main {null,run,stop,start} {start,fix}

		run: done
		destroy: done




-------------DEPENDENCIES-------------------
create docker network: docker network create ltu.miguel.ganglia
Docker 1.9
jq ( sudo apt-get install jq )

