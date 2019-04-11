#!/bin/sh

# generates both password and hash.  Delete the one you dont want.  In some
# places you need the actual password, and other can work with a hash.

if [ $# -ne 3 ];
    then echo "illegal number of parameters"
    echo "encrypt-password  username password target_file"
    echo "encrypt-password  foo bar vault_vars/foo.local/main.yml"
    exit 1
fi


echo "$1: '$2' in $3"

hash=`/usr/bin/python -c "from passlib.hash import sha512_crypt; print sha512_crypt.using(rounds=5000).hash('$2')"`


ansible-vault encrypt_string "$hash" --name $1_password_hash  \
    --vault-password-file ~/.private/vault_password.txt  >> $3

ansible-vault encrypt_string "$2" --name $1_password  \
    --vault-password-file ~/.private/vault_password.txt  >> $3
