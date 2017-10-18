#!/bin/bash

# See `bootstraph.sh` in `ableC-vm-artifact` repository for
# required packages.

# name of directory in which to install Silver and ableC.
INSTALLDIR="ableC-bundle"

# branches to install   - change to "master" later
BRANCH="develop"

set -eu

if [ -d ${INSTALLDIR} ]; then
  rm -rf ${INSTALLDIR}
fi

mkdir ${INSTALLDIR}
cd ${INSTALLDIR}


# Download and set up Silver.
git clone -b ${BRANCH} https://github.com/melt-umn/silver.git
cd silver
source update
mkdir -p ~/bin

./support/bin/install-silver-bin
# (cd silver/support/nailgun && ./install-sv-nailgun)
cd ..

# Download and set up ableC.
git clone -b ${BRANCH} https://github.com/melt-umn/ableC.git


# Download and set up the various extensions
mkdir -p extensions
cd extensions

git clone -b ${BRANCH} https://github.com/melt-umn/ableC-condition-tables.git


exit 0
echo "OH NO"



# Get ableC sample projects repository

git clone https://github.com/melt-umn/ableC_sample_projects.git
rm -rf ableC_sample_projects/using_transparent_prefixes


# To help keep VM size down, I decided not to pre-build AbleC.

# Download and set up the various extensions

mkdir -p extensions
cd extensions
git clone https://github.com/melt-umn/ableC-algebraic-data-types.git
git clone https://github.com/melt-umn/ableC-cilk.git
git clone https://github.com/melt-umn/ableC-closure.git

git clone https://github.com/melt-umn/ableC-interval.git
git clone https://github.com/melt-umn/ableC-halide.git
git clone https://github.com/melt-umn/ableC-string.git
git clone https://github.com/melt-umn/ableC-sqlite.git
git clone https://github.com/melt-umn/ableC-regex-lib.git
git clone https://github.com/melt-umn/ableC-regex-pattern-matching.git
git clone https://github.com/melt-umn/ableC-templating.git
########################################




echo "Downloading an installing Silver..."
wget -q http://melt.cs.umn.edu/downloads/silver-dev/silver-latest.tar.gz
tar zxf silver-latest.tar.gz
mv silver-latest silver
mkdir -p bin
(cd silver && ./support/bin/install-silver-bin)
(cd silver/support/nailgun && ./install-sv-nailgun)
rm silver-latest.tar.gz

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

# Download and set up AbleC.

git clone https://github.com/melt-umn/ableC.git
rm -Rf ~/ableC/extensions

# Get ableC sample projects repository

git clone https://github.com/melt-umn/ableC_sample_projects.git
rm -rf ableC_sample_projects/using_transparent_prefixes


# To help keep VM size down, I decided not to pre-build AbleC.

# Download and set up the various extensions

mkdir -p extensions
cd extensions
git clone https://github.com/melt-umn/ableC-algebraic-data-types.git
git clone https://github.com/melt-umn/ableC-cilk.git
git clone https://github.com/melt-umn/ableC-closure.git
git clone https://github.com/melt-umn/ableC-condition-tables.git
git clone https://github.com/melt-umn/ableC-interval.git
git clone https://github.com/melt-umn/ableC-halide.git
git clone https://github.com/melt-umn/ableC-string.git
git clone https://github.com/melt-umn/ableC-sqlite.git
git clone https://github.com/melt-umn/ableC-regex-lib.git
git clone https://github.com/melt-umn/ableC-regex-pattern-matching.git
git clone https://github.com/melt-umn/ableC-templating.git


#rm -f */Jenkinsfile

cd ..

# Anything else?

