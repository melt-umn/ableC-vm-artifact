#!/bin/bash

# Checks out a given branch name
if [[ $# > 0 ]]; then
    BRANCH=$1
else
    BRANCH=develop
fi

# Branch to check out if an extension doesn't have a branch
DEFAULT_BRANCH=develop

# name of directory where ableC is installed
if [[ $# > 1 ]]; then
    INSTALLDIR=$1
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

set -e

CHECKOUTDIRS="silver ableC extensions/ableC-* ableC_sample_projects"

echo "Checking out branch ${BRANCH}"
for dir in ${CHECKOUTDIRS}
do
    echo "Checking out for $dir..."
    (
        cd $dir
        if ! git rev-parse --verify ${BRANCH} &> /dev/null; then
            echo "Repo doesn't have branch ${BRANCH}, checking out ${DEFAULT_BRANCH} instead."
            git checkout ${DEFAULT_BRANCH}
        else
            git checkout ${BRANCH}
        fi
    )
done
