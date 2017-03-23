#!/bin/bash

function removeContainer(){
    while [[ $# != 0 ]]; do
    
      umount /var/lib/docker/aufs/mnt/
    done

}
