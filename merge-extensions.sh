#!/bin/bash

# Merges another branch into the current branch for all extensions

# Get the branch to merge
if [[ $# > 0 ]]; then
    BRANCH=$1
else
    echo "error: Expected a branch to merge"
    exit 1
fi

# Name of directory where ableC is installed
if [[ $# > 1 ]]; then
    INSTALLDIR=$2
elif [[ -d ableC && -d extensions ]]; then
    INSTALLDIR=.
else
    INSTALLDIR="ableC-bundle"
fi

if [ ! -d ${INSTALLDIR} ]; then
    echo "error: Bundle directory ${INSTALLDIR} does not exist"
    exit 1
fi

cd ${INSTALLDIR}

# Abort on failure
set -e

cd extensions

# First merge all the extensions
for extdir in ableC-*
do
    echo "Merging $extdir..."
    (cd $extdir && git merge ${BRANCH})
done

# If that went OK then push all the extensions
for extdir in ableC-*
do
    echo "Pushing $extdir..."
    (cd $extdir && git push)
done
