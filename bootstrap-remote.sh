#!/bin/bash

if [ ! -f ~/.private/ansible/vault_password.txt ] ; then
    echo 'ERROR: private files not available'
    exit 1
fi

if [[ -z "$1" ]] ; then
    echo 'ERROR: missing parameters'
    echo "     $0   user@hostname [newname]"
    echo
    echo "     user@hostname is the username and host to connect to.  For a"
    echo "     raspberry pi it will most likely be 'pi@raspberrypi.local'"
    echo
    echo "     newname is the optional name to rename the host to.  only"
    echo "     for a raspberry pi.  Use the hostname, not the domain part."
    exit 1
fi

address=$1
newname=$2

hostname=$(echo $address | cut -d'@' -f 2)
username=$(echo $address | cut -d'@' -f 1)

# echo $username
# echo $hostname
# echo $newname

# reset local known_hosts for orig name
ssh-keygen -R ${hostname} >/dev/null
ssh-keyscan -H ${hostname} >~/.ssh/known_hosts  2>/dev/null

# copy cert to remote
ssh-copy-id -i ~/.ssh/id_ed25519.pub $address
read -p "Press enter to continue"

# check if we can connect
ansible $hostname -m ping -u $username
read -p "Press enter to continue"

# rename host if new name supplied
if [[ -n "$newname" ]] ; then

  # rename host
  ansible $hostname  -m ansible.builtin.include_role -a "name=pi-hostname"  \
      -e new_hostname=$newname  -u username
  read -p "Press enter to continue"

  # reset local known_hosts for new name
  ssh-keygen -R ${origname} >/dev/null
  ssh-keygen -R ${newname}.local >/dev/null
  ssh-keyscan -H ${newname}.local  >~/.ssh/known_hosts  2>/dev/null

fi

# Now run the playbook
ansible-playbook bootstrap-create-user.yml -e host=$hostname \
       --ask-become-pass -u $username
