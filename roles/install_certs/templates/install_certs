#!/bin/bash

rclone copy nextcloud-{{nextcloud_user}}:letsencrypt/ ~  --verbose

cd /etc/letsencrypt
tar xJf ~/letsencrypt.tar.xz
rm ~/letsencrypt.tar.xz
