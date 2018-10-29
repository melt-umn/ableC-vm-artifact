#!/bin/bash

# Deletes a given remote branch on all repositiories

# Get the branch to check out
if [[ $# > 0 ]]; then
    BRANCH=$1
else
    BRANCH=develop
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

REPOS="silver ableC extensions/silver-ableC extensions/ableC-* ableC-*"

echo "Deleting remote branch ${BRANCH}"
for dir in ${REPOS}
do
    echo "Deleting for $dir..."
    repo=github.com:melt-umn/$(basename $dir)
    (
        cd $dir
        if [[ ! $(git ls-remote --heads git@$repo.git $BRANCH) ]]; then
            echo "Repo doesn't have remote branch ${BRANCH}, skipping."
        else
            git push origin :$BRANCH
        fi
    )
done
