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

echo "Pushing Silver..."
cd silver
git push
cd ..

echo "Pushing ableC..."
cd ableC
git push
cd ..

echo "Pushing silver-ableC..."
cd extensions/silver-ableC
git push
cd ../..

echo "Pushing ableP..."
cd ableP
git push
cd ..

echo "Pushing ableC projects..."
for dir in ableC-*
do
    echo "Pushing $dir..."
    (cd $dir && git push)
done

echo "Pushing extensions..."
cd extensions
for dir in ableC-*
do
    echo "Pushing $dir..."
    (cd $dir && git push)
done
