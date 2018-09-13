#!/bin/bash

if [ ! -f ~/.private/vault_password.txt ] ; then
    echo 'ERROR: private files not available'
    exit 1
fi


if [[ -z "$1" ]] ; then
    echo 'ERROR: missing parameter'
    echo "     $0   newhostname"
    exit 1
fi





hostname=$1


# check if we can connect
ansible -v localhost -i inventory -m ping
read -p "Press enter to continue"


# Now run the playbook
ansible-playbook bootstrap-pimusicbox1.yml -i inventory  --ask-become-pass  \
      -e new_hostname=${hostname}


echo "----------------------------------------------------"
echo "Now remove the SD card and boot up your Raspberry Pi"
echo "----------------------------------------------------"
read -p "Press enter to continue"


ssh-keygen -R ${hostname}.local >/dev/null
ssh-keyscan -H ${hostname}.local  >~/.ssh/known_hosts  2>/dev/null


# check if we can connect
ansible -v ${hostname}.local -i "${hostname}.local," -m ping    \
      -u root -e ansible_ssh_pass=musicbox
read -p "Press enter to continue"

ansible-playbook bootstrap-pimusicbox2.yml -i "${hostname}.local,"   \
      -e host=${hostname}.local -e ansible_ssh_pass=musicbox  \
      --vault-password-file ~/.private/vault_password.txt
