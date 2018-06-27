#!/bin/bash



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
ssh-copy-id pi@$target -i ~/.ssh/id_rsa.pub

# check if we can connect
ansible $target -i "$target," -m ping -u pi
read -p "Press enter to continue"

# Now run the playbook
ansible-playbook bootstrap-raspbianstretch.yml -i "$target,"       \
      -e host=$target  -e new_hostname=$hostname       \
      --vault-password-file ~/.private/vault_password.txt
