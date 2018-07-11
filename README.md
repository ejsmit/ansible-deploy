# My Ansible setup

## Requirements

- python
- ssh-copy-id
- ~/.private/vault_password.txt,  dir 700, files 600, even better if encrypted
directory using encfs, gocryptfs, cryfs, etc.

## bootstrap

runs only once.  prepare target host for regular playbook.   Usually separate
scripts per OS distribution/version.   Does the following:

* make sure hostname is correct, especially for Raspberry pi servers which
start out with a hardcoded name on the image
* make sure deploy user exists   (where relevant)
* install any ansible client prerequisites

Run the script without parameters to display any required parameters.  This will
usually be the address, sometimes with username, as well as new target hostname
to rename to.

## Vault tools

Scripts to encrypt sensitive information into ansible vault.  Personal preference is
for vault files to be manually and explicitly included where needed, and not form
part of host_vars.   The password file option is included on the command line and
points to a encrypted volume on disk that can be mounted and unmounted when required.

Two scripts:
- encrypt passwords:  save both the encrypted password and password hash to a yaml file.  if one is not needed then it van be manually deleted.
- encrypt file contents:  save both file contents and file name to a yaml file.  I typically use this for certificates that need to be deployed.


## deploy user

New user, used with ssh key logins, passwordless sudo enabled.  Never use this
user for anything except remote ansible connections.

## run.sh script

The main script to configure the system.   Don't blindly run this more than once. For me
the main use is initial configuration of my own systems, so parts of it will cause
problems if run again.

Requires a hostname as first parameter. (actually it is the name of a yml file without the
.yml extension) and a optional username if deploy should not be used.