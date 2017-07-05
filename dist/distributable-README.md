
This is a VirtualBox VM Image.

You can register it using:

```
VBoxManage registervm `readlink -f ableC_artifact_vm/ableC_artifact_vm.vbox`
```

This image does not come with an X installation to save size. We recommend using the VM in headless mode and accessing it by SSH (which allows you to use a good terminal emulator instead of virtual box's console):

```
VBoxManage startvm ableC_artifact_vm --type headless
```

You may need to wait a moment for it to boot.

```
ssh ubuntu@127.0.0.1 -p 2222
```

The password is `ablec` all lower case. A README in the home directory will take things from there.


Shutdown
--------


```
VBoxManage controlvm ableC_artifact_vm acpipowerbutton
```

Will gracefully shutdown the VM. Or

```
VBoxManage controlvm ableC_artifact_vm poweroff
```

To force it off. If done with it, you can unregister this VM with:

```
VBoxManage unregistervm ableC_artifact_vm
```


Alternative SSH port
--------------------

By default, the VM creates a local port forward from "127.0.0.1:2222" to SSH into the guest VM. You can modify this (after rtegistering the machine) to e.g. 3022:

```
BoxManage modifyvm ableC_artifact_vm --natpf1 "ssh,tcp,,3022,,22"
```

Machine configuration
---------------------

This VM is given 4 cores, and 4GB of RAM. You may wish to increase this if you have plans to try more _interesting_ experiments (for instance, more core to do parallel computation with the Cilk extension.)

This is, however, enough for the examples we have set up.

