Setup
-----

```
apt install vagrant virtualbox
vagrant box add ubuntu/xenial64
```

This should install vagrant, virtual box, and then downloads the VM base image we're using.

Creating a  VM image
--------------------

### Clone this repo
Clone this repo and `cd` into it.

### Building VM
```
vagrant up
```
This references the `Vagrantfile` and constructs the VM and runs it in the background.

If the bootstrap files are modified, run
```
vagrant provision
```
to get the to run again

#### Test it
```
vagrant ssh
```
This logs into the VM.  One can poke around and see that things work.  When finished, logout as usual with `exit` to return to the host OS.


Extracting VM
-------------
```
vagrant halt
```

Stops the VM without deleting it like `destroy` does.

Then `~/VirtualBox VMs/ableC_artifact_vm` is the VM. I *think* we distribute this but just taring up this directory.


Cleaning up
-----------
```
vagrant destroy
```
This deletes the VM and stuff.



TODO
----

* [ ] Get all the AbleC extensions we want in here
* [ ] Create an outside VM README: "Here is how to start and use this VM"
  * [ ] Related: consider figuring out how to configure virtual box so you can SSH in from a terminal after starting the vm, instead of having to use the kinda crummy virtual box console.
* [ ] Create a composition example: "Here is AbleC composed with several extensions, and an example file."

