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

echo "Building Silver..."
cd silver
./self-compile
cd ..

echo "Building ableC..."
cd ableC
./build
cd ..

echo "Building silver-ableC..."
cd extensions/silver-ableC
./self-compile
cd ../..

echo "Building ableC projects..."
for dir in ableC-*
do
    echo "Building $dir..."
    (cd $dir && make -j4)
done

echo "Building extensions..."
cd extensions
for dir in ableC-*
do
    echo "Building $dir..."
    (cd $dir && make -j4)
done
