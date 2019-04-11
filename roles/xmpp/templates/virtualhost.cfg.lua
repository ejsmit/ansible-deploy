VirtualHost "{{prosody_chat_domain}}"

        ssl = {
                key = "/etc/prosody/certs/{{prosody_ssl_domain}}.key";
                certificate = "/etc/prosody/certs/{{prosody_ssl_domain}}.crt";
                }

Component "{{prosody_conference_domain}}" "muc"
