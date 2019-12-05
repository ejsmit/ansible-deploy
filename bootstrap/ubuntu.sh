#!/bin/bash

if [ ! -f ~/.private/ansible/vault_password.txt ] ; then
    echo 'ERROR: private files not available'
    exit 1
fi

if [[ -z "$1" ]] ; then
    echo 'ERROR: missing parameters'
    echo "     $0   user@address"
    exit 1
fi


address=$1

host=$(echo $address | cut -d'@' -f 2)
user=$(echo $address | cut -d'@' -f 1)

#echo $user
#echo $host

# enable passwordless login
ssh-keygen -R ${host} >/dev/null
ssh-keyscan -H ${host}  >~/.ssh/known_hosts  2>/dev/null
ssh-copy-id -i ~/.ssh/id_rsa.pub $host

# check if we can connect
ansible $host -i "$host," -m ping -u $user -e 'ansible_python_interpreter=/usr/bin/python3'
read -p "Press enter to continue"


# Now run the playbook
# debug with echo, -vvv
ansible-playbook bootstrap/bootstrap-generic-useronly.yml -i inventory   \
      -e host=$host  -u $user  --ask-become-pass                         \
      --vault-password-file ~/.private/ansible/vault_password.txt
