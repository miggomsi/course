
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
