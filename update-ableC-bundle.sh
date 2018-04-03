#!/bin/bash

# Name of directory where ableC is installed
if [[ $# > 0 ]]; then
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

echo "Updating Silver..."
cd silver
source update
cd ..

echo "Updating ableC..."
cd ableC
git pull
cd ..

echo "Updating ableC projects..."
for dir in ableC-*
do
    echo "Updating $dir..."
    (cd $dir && git pull)
done

echo "Updating extensions..."
cd extensions
for dir in ableC-*
do
    echo "Updating $dir..."
    (cd $dir && git pull)
done
