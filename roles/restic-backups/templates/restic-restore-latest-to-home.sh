#!/bin/bash

RESTORE_DEST=/home/{{default_user}}/restore

# exit if restore directory exists
if [ -d $RESTORE_DEST ]; then
  echo "Restore directory for user {{default_user}} already exists! Exiting..."
  exit 0
fi

# Create restore directory
mkdir -p $RESTORE_DEST

# restore everything
/usr/local/bin/restic-backup.sh restore latest --target $RESTORE_DEST
chown -R {{default_user}}:{{default_user}} $RESTORE_DEST
