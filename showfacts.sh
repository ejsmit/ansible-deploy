#!/bin/sh

if [ -z "$1" ] ; then
    echo 'ERROR: no target supplied'
    echo "     $0   hostname [user]"
    exit 1
fi
hostname=$1

user=deploy
[ "$2" ] && user=$2

# use -v or -vvv for debugging
ansible $hostname -v -i inventory -u $user -m setup | less
