#!/bin/bash

set -eu

# Remove all Git files
find . -name .gitignore -delete
find . -name .git -type d -print0|xargs -0 rm -r --

if [ -d ableC-bundle ]; then
    cd ableC-bundle

    tar cfz ableC.tgz ableC
    mv ableC.tgz ..

    tar cfz extensions.tgz extensions
    mv extensions.tgz ..

    cd ../
    tar cfz ableC-bundle.tgz ableC-bundle
fi
