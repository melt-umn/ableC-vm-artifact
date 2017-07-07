#!/bin/bash

set -eu

mv /home/ubuntu/motd /etc/motd
mv /home/ubuntu/issue /etc/issue

apt-get update

# Reduce VM size a bit:
# Mostly server-y stuff we don't need.
# Notably, however, remove unattended-upgrades. We don't want users to get a VM with packages we haven't tested because it updated itself.
apt-get purge -y snapd lxd lxd-client geoip-database xfsprogs btrfs-tools lvm2 mdadm open-vm-tools unattended-upgrades

# Install our prerequisites: for silver, ablec, all the extensions
apt-get install --no-install-recommends -y openjdk-8-jdk-headless ant wget git build-essential nailgun libgc-dev sqlite3 libsqlite3-dev

# Remove APT cache - reduce VM size
apt-get clean -y
apt-get autoclean -y

# Set up so reviewers can log in
yes ablec | passwd ubuntu

