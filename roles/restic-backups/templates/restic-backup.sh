#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "I must be  root!"
   exit 1
fi

source {{restic_environment_file}}
restic --no-cache "$@"
