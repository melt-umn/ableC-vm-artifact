# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # The base image we're starting from. Ubuntu 16.04
  config.vm.box = "ubuntu/xenial64"
  #config.vm.box_version = "20170626.0.0"

  # Make it easier to find this machine in VirtualBox
  config.vm.provider "virtualbox" do |v|
    v.name = "ableC_artifact_vm"
    v.memory = 4096
    v.cpus = 4
  end

  # apt install whatever we need
  config.vm.provision "shell", path: "bootstrap.sh"
  
  #Copying a file in:
  #config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  # A README in ~
  # Perhaps a /etc/motd?
  
  # Set up what we want in the home directory of the VM
  config.vm.provision "shell", path: "bootstrap-homedir.sh", privileged: false
end
