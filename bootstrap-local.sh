#!/bin/bash

if [ ! -f ~/.private/ansible/vault_password.txt ] ; then
    echo 'ERROR: private files not available'
    exit 1
fi


hostname=localhost

# check if we can connect
ansible $hostname -m ping
read -p "Press enter to continue"

# Now run the playbook
ansible-playbook bootstrap-create-user.yml \
      -e host=$hostname \
      --ask-become-pass
