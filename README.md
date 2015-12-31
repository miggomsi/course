# course
This is for the students that are taking the course in LTU


It is neccessary to have at least Docker 1.8 that contains Docker Network.

Before running any script you must create the network and install jq. Jq is used to get the IP address where ganglia will be running on.

  - sudo docker network create ltu.miguel.ganglia
  - sudo apt-get install jq

runNetwork.sh script creates the network and connects all the containers. 

  - 1 gmetad container with gweb
  - 1 gmond container that creates cluster1. This cluster will received the metrics from the host
  - 1 gmond container for redundancy
  - 2 gmond container for other cluster
  - 1 hostsflow agent container modified to get the metrics from the host.

