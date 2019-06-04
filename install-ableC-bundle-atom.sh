#!/bin/bash

# This is a modified version of install-ableC-bundle to use the
# tree-sitter branch of things.

# See `bootstraph.sh` in `ableC-vm-artifact` repository for
# required packages.

# Name of directory in which to install Silver and ableC.
if [[ $# > 0 ]]; then
    INSTALLDIR=$1
else
    INSTALLDIR="ableC-bundle-atom"
fi

echo "Installing ableC bundle into ${INSTALLDIR}..."

# branches to install, this changes frequently below
BRANCH="feature/treesitter"

set -eu

if [[ -d ${INSTALLDIR} ]]; then
    rm -rf ${INSTALLDIR}/silver
    rm -rf ${INSTALLDIR}/silver-ide
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

./self-compile
cp build/silver.composed.Default.jar jars/

mkdir -p ~/bin
rm -f ~/bin/silver ~/bin/silver-custom

./support/bin/install-silver-bin
# (cd silver/support/nailgun && ./install-sv-nailgun)
cd ..


# Get Silver IDE tools
git clone git@github.com:melt-umn/silver-ide.git
cd silver-ide

# I had to do this explicitly.
mkdir -p jars

./build-everything

exit 999

# Download and set up ableC.
# To help keep VM size down, ableC is not pre-built.
BRANCH="feature/ide_support"
git clone -b ${BRANCH} https://github.com/melt-umn/ableC.git

# Download and set up the various extensions
mkdir -p extensions
cd extensions

git clone -b ${BRANCH} https://github.com/melt-umn/ableC-algebraic-data-types.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-cilk.git

git clone -b ${BRANCH} https://github.com/melt-umn/ableC-regex-lib.git

# The repositories below do not have treesitter branches
BRANCH="develop"
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-check.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-checkTaggedUnion.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-closure.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-condition-tables.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-constructor.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-halide.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-interval.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-nonnull.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-prolog.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-refcount-closure.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-regex-pattern-matching.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-rewriting.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-sqlite.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-string.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-templating.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-template-algebraic-data-types.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-tensor-algebra.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-unification.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-vector.git
git clone -b ${BRANCH} https://github.com/melt-umn/ableC-watch.git


BRANCH="develop"

# Download and setup silver-ableC
git clone -b ${BRANCH} https://github.com/melt-umn/silver-ableC.git
cd silver-ableC

# ./bootstrap-compile
./fetch-jars

./support/bin/install-silver-bin

cd ..


#rm -f */Jenkinsfile   ?

cd ..

# Get ableC sample project repositories
git clone https://github.com/melt-umn/ableC-sample-projects.git

# git clone https://github.com/melt-umn/ableC-nondeterministic-search-benchmarks.git

# Anything else?
