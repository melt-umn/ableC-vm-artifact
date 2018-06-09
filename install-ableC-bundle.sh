#!/bin/bash

# See `bootstraph.sh` in `ableC-vm-artifact` repository for
# required packages.

# Name of directory in which to install Silver and ableC.
if [[ $# > 0 ]]; then
    INSTALLDIR=$1
else
    INSTALLDIR="ableC-bundle"
fi

echo "Installing ableC bundle into ${INSTALLDIR}..."

# branches to install
BRANCH="master"

set -eu

if [[ -d ${INSTALLDIR} ]]; then
    rm -rf ${INSTALLDIR}/silver
    rm -rf ${INSTALLDIR}/ableC
    rm -rf ${INSTALLDIR}/ableC-sample-projects
    rm -rf ${INSTALLDIR}/extensions
else
    mkdir -p ${INSTALLDIR}
fi

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
# To help keep VM size down, ableC is not pre-built.
git clone -b ${BRANCH} https://github.com/melt-umn/ableC.git

# Download and set up the various extensions
mkdir -p extensions
cd extensions

git clone -b ${BRANCH} https://github.com/melt-umn/ableC-algebraic-data-types.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-cilk.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-closure.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-refcount-closure.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-condition-tables.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-interval.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-halide.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-string.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-sqlite.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-regex-lib.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-regex-pattern-matching.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-templating.git

# Download and setup silver-ableC
git clone -b ${BRANCH} https://github.com/melt-umn/silver-ableC.git
cd silver-ableC

./bootstrap-compile # TODO: Release the jars somewhere and download them from there instead of building fresh

./support/bin/install-silver-bin

cd ..


#rm -f */Jenkinsfile   ?

cd ..

# Get ableC sample projects repository
git clone https://github.com/melt-umn/ableC-sample-projects.git

# Anything else?

