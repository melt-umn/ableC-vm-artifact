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


TAG_NAME=ableC-${ABLEC_VERSION}

cd extensions
for extdir in ableC-*
do
    echo "Tagging $extdir..."
    (
        cd $extdir
        # Safety check first... make sure we are on master
        if [[ $(git rev-parse --abbrev-ref HEAD) != master ]]; then
            echo "error: Not on branch master"
        else
            git tag ${TAG_NAME} && git push origin ${TAG_NAME}
        fi
    )
done
