#!/bin/bash

# Checks out a given branch name

# Get the branch to check out
if [[ $# > 0 ]]; then
    BRANCH=$1
else
    BRANCH=develop
fi

# Branch to check out if an extension doesn't have a branch
DEFAULT_BRANCH=develop

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

REPOS="silver ableC extensions/silver-ableC extensions/ableC-* ableC-* ableP"

echo "Checking out branch ${BRANCH}"
for dir in ${REPOS}
do
    echo "Checking out for $dir..."
    (
        cd $dir
        if ! git checkout ${BRANCH}; then
            echo "Repo doesn't have branch ${BRANCH}, checking out ${DEFAULT_BRANCH} instead."
            git checkout ${DEFAULT_BRANCH}
        fi
    )
done
