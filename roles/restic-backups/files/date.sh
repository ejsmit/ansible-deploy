#!/bin/sh

BACKUP_DEST=$1

echo mybackup > ${BACKUP_DEST}/$(date '+%Y-%m-%d').txt
