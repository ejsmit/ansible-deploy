#!/bin/bash

source /etc/mybackup/backup.conf

date | tee -a ${BACKUP_LOG}  ${BACKUP_DEST}/$(date '+%Y-%m-%d').txt
