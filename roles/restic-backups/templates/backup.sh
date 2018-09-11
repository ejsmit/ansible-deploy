#!/bin/bash

BACKUP_DEST={{backup_destination}}

# Clear backup directory
mkdir -p ${BACKUP_DEST}
rm -rf ${BACKUP_DEST}/*


# run scripts to copy files into BACKUP_DEST

if [ -d /etc/mybackup/scripts.d ]; then
  for i in /etc/mybackup/scripts.d/*.sh; do
    if [ -r $i ]; then
      . $i ${BACKUP_DEST}
    fi
  done
  unset i
fi

/usr/local/bin/restic backup ${BACKUP_DEST}
