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
* [ ] ableC
  * [X] clear out extensions directory
  * [X] rewrite README.md in ableC repo (MAYBE done -- needs review?)

* [X] Get all the AbleC extensions we want in here

* [ ] (Optional) Figure out how to compact the VM image more. (Currently 800MB, probably could be 5-600.)

* [ ] Extensions
  * [ ] get them to have the same format, some new regex ones don't

* [ ] Create a composition examples
  * [ ] parallel tree search
  * [ ] 'down on the farm'
  * [X] transparent prefixes - remove this

* [X] Getting Started

* [ ] Step-by-step
  * [ ] explain useless NT messages in closure since it uses the
        parsing construction stuff...

* [ ] read paper and get more exts - intervals...


Keep in mind:

"The AEC strives to place itself in the shoes of such future
researchers and then to ask: how much would this artifact have helped
me?" 
