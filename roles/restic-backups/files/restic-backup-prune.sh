#!/bin/bash

/usr/local/bin/restic-backup.sh forget --prune \
            --keep-last 5 --keep-daily 7 \
            --keep-weekly 5 --keep-monthly 12
