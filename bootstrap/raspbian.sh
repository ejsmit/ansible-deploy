#!/bin/bash

if [ ! -f ~/.private/ansible/vault_password.txt ] ; then
    echo 'ERROR: private files not available'
    exit 1
fi

if [[ -z "$1" || -z "$2" ]] ; then
    echo 'ERROR: missing parameters'
    echo "     $0   address newhostname"
    echo "          address will most likely be raspberrypi.local"
    echo "          but ip address may be required"
    exit 1
fi


target=$1
hostname=$2


# enable passwordless login
ssh-keygen -R ${target} >/dev/null
ssh-keyscan -H ${target}  >~/.ssh/known_hosts  2>/dev/null

ssh-copy-id -i ~/.ssh/id_rsa.pub pi@$target
read -p "Press enter to continue"


# check if we can connect
ansible $target -i "$target," -m ping -u pi
read -p "Press enter to continue"

# Now run the playbook
ansible-playbook bootstrap/bootstrap-raspbian.yml -i inventory       \
      -e host=$target  -e new_hostname=$hostname --ask-become-pass   \
      --vault-password-file ~/.private/ansible/vault_password.txt
