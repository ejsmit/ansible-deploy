#!/bin/bash

source /etc/mybackup/backup.conf

echo "Backing up thumbnails & addons (external disk)" | tee -a ${BACKUP_LOG}

mkdir -p /media/$EXTERNAL_DISK/backup
rsync -zah /home/$DEFAULT_USER/.kodi/userdata/Thumbnails  /media/$EXTERNAL_DISK/backup --delete
rsync -zah /home/$DEFAULT_USER/.kodi/addons  /media/$EXTERNAL_DISK/backup --delete

echo "Backing up settings" | tee -a ${BACKUP_LOG}

cd ${BACKUP_DEST}
tar Jcf kodi.tar.xz --exclude="/home/$DEFAULT_USER/.kodi/userdata/Thumbnails" /home/$DEFAULT_USER/.kodi/userdata
