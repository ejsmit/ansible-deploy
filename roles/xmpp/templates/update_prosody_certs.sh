#!/bin/bash

cp /etc/letsencrypt/live/{{prosody_ssl_domain}}/fullchain.pem  \
    /etc/prosody/certs/{{prosody_ssl_domain}}.crt

cp /etc/letsencrypt/live/{{prosody_ssl_domain}}/privkey.pem   \
    /etc/prosody/certs/{{prosody_ssl_domain}}.key
chmod 640 /etc/prosody/certs/{{prosody_ssl_domain}}.key
chown root:prosody /etc/prosody/certs/{{prosody_ssl_domain}}.key
