#!/bin/sh


if [ -z "$1" ] ; then
    echo 'ERROR: no target supplied'
    echo "     $0   hostname [user]"
    exit 1
fi
ymlfile=$1

user=deploy
[ "$2" ] && user=$2

# use -v or -vvv for debugging
ansible-playbook $ymlfile.yml -v -i inventory -u $user  \
      --vault-password-file ~/.private/vault_password.txt
