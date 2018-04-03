#!/bin/bash

# Tags as ableC-<ableC version> in preparation for a release

# Get the version number
if [[ $# > 0 ]]; then
    ABLEC_VERSION=$1
else
    echo "error: Expected ableC version"
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

cd extensions

TAG_NAME=ableC-${ABLEC_VERSION}
REPOS="ableC-*"
# Safety check first... make sure we are on master
for dir in ${REPOS}
do
    echo "Tagging $dir..."
    (
        cd $dir
        if [[ $(git rev-parse --abbrev-ref HEAD) != master ]]; then
            echo "error: Not on branch master"
            exit 1
        fi
    )
done

# Tag the extensions
for dir in ${REPOS}
do
    echo "Tagging $dir..."
    (
        cd $dir
        git tag ${TAG_NAME} && git push origin ${TAG_NAME}
    )
done
