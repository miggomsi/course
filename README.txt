
This is the version done for the students


	There are 2 images

		miggom/course-gmetad:1.01 This contains the gmetad gmond and the apache2
		miggom/course-gmond:1.0 This runs the gmond
		miggom/course-hsflow:1.0 This runs the hsflow


There are 4 gmonds 1 gmetad 1 hsflow taking the metrics from the host

############################ date 12-02-16############################################################

In this version there is a Coma Container. First part that is done is to create the container with the docker.sock bound
and the name is put. The file created is runComa.sh

############################ date 17-02-16 ############################################################

I'm doing a docker-compose to start the container but I think that I will not use it in the end

In the end I think that I will publish the coma container into the network and that's it because I can not deploy  the server
bound with docker into a container.

I have a script that deploys the Docker server and then my dockerremoteapi will perform the requests to that container
I need to link it or bind the folder where hsflow.conf is located. I need to do it with the --volume-from flag of run


I have two new files

	-startSERVERDOCKER.sh. This will start the server
	-main {null,run,stop,start} {start,fix}

############################ date 02-03-16 ############################################################


Now the main.sh deployes and destroyes automatically the server.
There is a problem with the apache running in the image. The problem is that, for some reason it does not allow to run the PID
I need to fix this but is going to be a bit hard since there is not only solution although people have the same problem


I have two new files
		-startSERVERDOCKER.sh. This will start the server  (done in main)
		-main {null,run,stop,start} {start,fix}

		run: done
		destroy: done


############################ date 27-06-16 ############################################################

Trying to fix the error in case we can make the demo in the workshop to the girl that works in Ericcsson

I have the version of the monitoring system without the CoMa implementation included. However in this version we are close to fix the error that does not allow to run coma. The error is copying the file from hostsflow.

The file modified is runComa.sh


-------------DEPENDENCIES-------------------
Docker 1.9
jq ( sudo apt-get install jq )
