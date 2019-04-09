#!/bin/bash

source /etc/mybackup/backup.conf

# backup pihole
echo "Running letsencrypt certificate backup..." | tee -a ${BACKUP_LOG}
cd ${BACKUP_DEST}
/usr/local/bin/pihole -a -t
tar Jcf /etc/letsencrypt letsencrypt-$(date '+%Y-%m-%d').tar.xz
