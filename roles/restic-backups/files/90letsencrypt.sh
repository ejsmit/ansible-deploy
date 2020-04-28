#!/bin/bash

source /etc/mybackup/backup.conf

# backup pihole
echo "Running letsencrypt certificate backup..." | tee -a ${BACKUP_LOG}
cd ${BACKUP_DEST}
tar Jcf  letsencrypt.tar.xz /etc/letsencrypt/
