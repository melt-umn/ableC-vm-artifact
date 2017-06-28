Setup
-----

```
apt install vagrant virtualbox
vagrant box add ubuntu/xenial64
```

This should install vagrant, virtual box, and then downloads the VM base image we're using.

Building VM
-----------

```
vagrant up
```

Cleaning up
-----------

```
vagrant destroy
```

Deletes the VM and stuff

Extracting VM
-------------

```
vagrant halt
```

Stops the VM without deleting it like `destroy` does.

Then `~/VirtualBox VMs/ableC_artifact_vm` is the VM. TODO: Figure out how to distribute this.

