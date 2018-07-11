#!/bin/sh

BACKUP_DEST=$1

# backup pihole

pushd $BACKUP_DEST >/dev/null

pihole -a -t

popd >/dev/null
