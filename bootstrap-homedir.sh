#!/bin/bash

set -eu

if [ -d silver ] || [ -d ableC ]; then
  rm -rf bin silver ableC extensions *.tar.gz || true
fi

# Download and set up Silver. (Presently using -latest.)

wget -q http://melt.cs.umn.edu/downloads/silver-dev/silver-latest.tar.gz
tar zxvf silver-latest.tar.gz
mv silver-latest silver
mkdir -p bin
(cd silver && ./support/bin/install-silver-bin)
rm silver-latest.tar.gz

# Download and set up AbleC.

git clone https://github.com/melt-umn/ableC.git

# To help keep VM size down, I decided not to pre-build AbleC.

# Download and set up the various extensions

mkdir -p extensions
cd extensions
git clone https://github.com/melt-umn/ableC-condition-tables.git
git clone https://github.com/melt-umn/ableC-cilk.git
cd ~

# Anything else?

