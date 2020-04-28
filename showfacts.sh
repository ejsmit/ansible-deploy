#!/bin/sh

if [ -z "$1" ] ; then
    echo 'ERROR: no target supplied'
    echo "     $0   hostname"
    exit 1
fi
hostname=$1
user=deploy

# use -v or -vvv for debugging
ansible $hostname -v  -u $user -m setup | less
