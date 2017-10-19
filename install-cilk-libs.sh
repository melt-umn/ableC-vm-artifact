#!/bin/bash

set -eu

# get cilk libraries
echo "Downloading Cilk libraries"
wget -q http://melt.cs.umn.edu/downloads/cilk-usr_local.tar.gz
tar zxf cilk-usr_local.tar.gz
sudo mkdir -p /usr/local/include/cilk
sudo chmod o+rx /usr/local/include/cilk
sudo cp cilk-usr_local/include/cilk/* /usr/local/include/cilk/
sudo chmod o+r /usr/local/include/cilk/*
sudo mkdir -p /usr/local/lib/cilk
sudo chmod o+rx /usr/local/lib/cilk
sudo cp cilk-usr_local/lib/cilk/* /usr/local/lib/cilk/
sudo chmod o+r /usr/local/lib/cilk/*
sudo cp cilk-usr_local/lib/lib* /usr/local/lib/
sudo chmod o+r /usr/local/lib/lib*
rm -rf cilk-usr_local*

