#!/bin/bash

if [ -z "$1" ] ; then
    echo 'ERROR: missing user@ipaddress and hostname'
    echo "     $0   user@ipaddress newhostname"
    exit 1
fi

if [ -z "$2" ] ; then
    echo 'ERROR: missing target hostname'
    echo "     $0   user@ipaddress newhostname"
    exit 1
fi


address=$1
hostname=$2
ip=$(echo $address | cut -d'@' -f 2)
user=$(echo $address | cut -d'@' -f 1)



# enable passwordless login
# not needed for ubuntu core SSO login
# ssh-copy-id pi@$address

# we need to explicitly specify python3 at this point.   once the host has been
# renamed it will happen automatically through the inventory file.

# check if we can connect
ansible $ip -i "$ip," -m ping -u $user -e 'ansible_python_interpreter=/usr/bin/python3'
read -p "Press enter to continue"

# Now run the playbook
ansible-playbook bootstrap-ubuntucore16.yml -i "$ip,"        \
      -e 'ansible_python_interpreter=/usr/bin/python3'       \
      -e host=$ip  -u $user  -e new_hostname=$hostname       \
      --vault-password-file ~/.private/vault_password.txt
