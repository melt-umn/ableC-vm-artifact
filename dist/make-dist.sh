#!/bin/bash

cd ..

if [ ! -d dist ]; then
  echo "Expected to run as ./make-dist.sh"
  exit 1
fi

if [ -d dist/ableC_artifact ]; then
  echo "Remove old artifact files before running. (Safety check: did you mean this?)"
  echo "rm -rf ableC_artifact*"
  exit 1
fi

# Get a fresh VM copy
vagrant destroy --force
vagrant up
vagrant halt

# reconfigure before copy: remove references to files on the local system.

# A UART is necessary for the VM to boot, so just "disconnect" it from anything.
VBoxManage modifyvm ableC_artifact_vm --uartmode1 disconnected
# Remove vagrant-specific configuration
VBoxManage sharedfolder remove ableC_artifact_vm --name vagrant

# Hope you have an SSD! WEEEEEEEEeeeeee
echo "Performing expensive copy of VM. Takes awhile."
cp -r ~/VirtualBox\ VMs/ableC_artifact_vm dist/

# Remove vagrant's copy.
# This is important since VBox has both names (ableC_artifact_vm)
# and UUIDs, so we don't want collisions.
vagrant destroy --force


cd dist

# Remove stale stuff we don't need to distribute
rm ableC_artifact_vm/*-prev
rm -rf ableC_artifact_vm/Logs

# Create the thing we tar up
mkdir -p ableC_artifact
cp distributable-README.md ableC_artifact/README.md
cp ../Getting-Started-Guide.md ableC_artifact/
cp ../Step-by-Step-Instructions.md ableC_artifact/
mv ableC_artifact_vm ableC_artifact/

echo "Compressing..."
tar zcf ableC_artifact.tar.gz ableC_artifact/

echo "artifact ready: ableC_artifact.tar.gz  or already uncompressed: ableC_artifact"

