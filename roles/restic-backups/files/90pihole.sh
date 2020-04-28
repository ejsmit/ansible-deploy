
#!/bin/bash

source /etc/mybackup/backup.conf

# backup pihole
echo "Running Pihole Teleporter..." | tee -a ${BACKUP_LOG}
cd ${BACKUP_DEST}
/usr/local/bin/pihole -a -t
mv pi-hole-teleporter*.tar.gz pihole-teleporter.tar.gz
