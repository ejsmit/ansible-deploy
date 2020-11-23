#!/bin/bash

rm -f {{nextcloud_backupsdir}}/mariabackup-*
docker exec $(docker ps -q -f name=nextcloud-db) /usr/bin/mariabackup --backup --stream=xbstream --user root --password=$(docker exec $(docker ps -q -f name=nextcloud-db) /bin/sh -c 'echo $MYSQL_ROOT_PASSWORD') | xz > {{nextcloud_backupsdir}}/nextcloud-mariabackup-$(date +"%Y-%m-%d_%H-%M-%S").xbstream.xz
