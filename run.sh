#!/bin/sh

# Assumes the use of deploy username and saved password

if [ ! -f ~/.private/ansible/vault_password.txt ] ; then
    echo 'ERROR: private files not available'
    exit 1
fi

if [ -z "$1" ] ; then
    echo 'ERROR: no target supplied'
    echo "     $0   ymlfile [hostname]"
    echo "     not all playbooks allow hostname to be specified"
    exit 1
fi

ymlfile=$1

hostname=""
[ "$2" ] && hostname="-e host=$2"

# use -v or -vvv for debugging
ansible-playbook $ymlfile -v  $hostname \
      --vault-password-file ~/.private/ansible/vault_password.txt
