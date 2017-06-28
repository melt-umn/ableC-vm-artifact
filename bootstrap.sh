#!/bin/bash

set -eu

apt update
apt install -y openjdk-8-jdk-headless ant git build-essential nailgun

# People are going to be using this VM right? Should we consider vim/emacs?

# Remove APT cache - reduce VM size
apt-get clean -y
apt-get autoclean -y

