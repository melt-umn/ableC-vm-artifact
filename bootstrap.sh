#!/bin/bash

set -eu

mv /home/ubuntu/motd /etc/motd
mv /home/ubuntu/issue /etc/issue

apt-get update
apt-get install -y openjdk-8-jdk-headless ant git build-essential nailgun 
apt-get install -y libgc-dev emacs

# People are going to be using this VM right? Should we consider vim/emacs?

# Remove APT cache - reduce VM size
apt-get clean -y
apt-get autoclean -y

# Set up so reviewers can log in
yes ablec | passwd ubuntu

