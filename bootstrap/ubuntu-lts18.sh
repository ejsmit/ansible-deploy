#!/bin/bash

if [ ! -f ~/.private/vault_password.txt ] ; then
    echo 'ERROR: private files not available'
    exit 1
fi

if [[ -z "$1" || -z "$2" ]] ; then
    echo 'ERROR: missing parameters'
    echo "     $0   address username"
    exit 1
fi


target=$1
username=$2
scriptpath=dirname "$0"

# enable passwordless login
ssh-keygen -R ${target} >/dev/null
ssh-keyscan -H ${target}  >~/.ssh/known_hosts  2>/dev/null

ssh-copy-id -i ~/.ssh/id_rsa.pub $username@$target
read -p "Press enter to continue"


# check if we can connect
ansible $target -i "$target," -m ping -u $username
read -p "Press enter to continue"

# Now run the playbook
ansible-playbook $scriptpath/bootstrap-ubuntu-lts18.yml -i "$target,"  --ask-become-pass     \
      -e host=$target  -e new_hostname=$hostname  -e user=$username     \
      --vault-password-file ~/.private/vault_password.txt
