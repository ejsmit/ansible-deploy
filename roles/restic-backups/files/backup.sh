#!/bin/bash

source /etc/mybackup/backup.conf

# Clear backup log file
: >${BACKUP_LOG}

# Clear backup directory
mkdir -p ${BACKUP_DEST}
rm -rf ${BACKUP_DEST}/*


# run scripts to copy files into BACKUP_DEST
run-parts --report /etc/mybackup/scripts.d

# now backup everything in BACKUP_DEST offsite
/usr/local/bin/restic-backup.sh backup ${BACKUP_DEST} | tee -a ${BACKUP_LOG}
