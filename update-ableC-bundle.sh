#!/bin/bash

# name of directory where ableC is installed
if [[ $# > 0 ]]; then
    INSTALLDIR=$1
elif [[ -d ableC && -d extensions ]]; then
    INSTALLDIR=.
else
    INSTALLDIR="ableC-bundle"
fi

if [ ! -d ${INSTALLDIR} ]; then
    echo "Bundle directory ${INSTALLDIR} does not exist"
    exit 1
fi

cd ${INSTALLDIR}

echo "Updating Silver..."
cd silver
source update
cd ..

echo "Updating ableC..."
cd ableC
git pull
cd ..

echo "Updating extensions..."
cd extensions
for extdir in ableC-*
do
    echo "Updating $extdir..."
    (cd $extdir && git pull)
done
