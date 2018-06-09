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

REPOS="extensions/silver-ableC extensions/ableC-* ableC-*"

# First merge all the extensions
for dir in ${REPOS}
do
    echo "Merging $dir..."
    (
        cd $dir
        if ! git rev-parse --verify ${BRANCH} &> /dev/null; then
            echo "Repo doesn't have branch ${BRANCH}, skipping."
        else
            git merge ${BRANCH}
        fi
    )
done

# If that went OK then push all the extensions
for dir in ${REPOS}
do
    echo "Pushing $dir..."
    (cd $dir && git push)
done
