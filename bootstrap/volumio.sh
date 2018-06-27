#!/bin/bash




if [[ -z "$1" || -z "$2" ]] ; then
    echo 'ERROR: missing parameters'
    echo "     $0   address newhostname"
    echo "          address will most likely be volumio.local"
    echo "          but ip address may be required"
    exit 1
fi


target=$1
hostname=$2


# enable passwordless login
ssh-copy-id volumio@$target -i ~/.ssh/id_rsa.pub

# check if we can connect
ansible $target -i "$target," -m ping -u volumio
read -p "Press enter to continue"

# Now run the playbook
ansible-playbook bootstrap-volumio.yml -i "$target,"       \
      -e host=$target  -e new_hostname=$hostname       \
      --vault-password-file ~/.private/vault_password.txt
