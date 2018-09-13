#!/bin/bash

source /etc/mybackup/backup.conf

# backup pihole
echo "Running Pihole Teleporter..." | tee -a ${BACKUP_LOG}
cd ${BACKUP_DEST}
/usr/local/bin/pihole -a -t
