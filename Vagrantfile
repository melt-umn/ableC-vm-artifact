# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # The base image we're starting from. Ubuntu 16.04
  config.vm.box = "ubuntu/xenial64"
  #config.vm.box_version = "20170626.0.0"

  config.vm.provider "virtualbox" do |v|
    # Make it easier to find this machine in VirtualBox
    v.name = "ableC_artifact_vm"
    # Enough memory to build things
    v.memory = 4096
    # Enough cores for cilk examples to be meaningful
    v.cpus = 4
  end

  # Tell virtual box users how to log in:
  config.vm.provision "file", source: "issue", destination: "issue"
  # Tell new logins to look for a README:
  config.vm.provision "file", source: "motd", destination: "motd"
  # Suggest building AbleC, building an extension, etc:
  config.vm.provision "file", source: "homedir-README", destination: "README"
  
  # apt install whatever we need
  config.vm.provision "shell", path: "bootstrap.sh"
  
  # Set up what we want in the home directory of the VM
  # config.vm.provision "shell", path: "bootstrap-homedir.sh", privileged: false


  config.vm.provision "file", source: "install-ableC-bundle.sh", destination: "install-ableC-bundle.sh"
  config.vm.provision "file", source: "update-ableC-bundle.sh", destination: "update-ableC-bundle.sh"
  config.vm.provision "file", source: "install-cilk-libs.sh", destination: "install-cilk-libs.sh"
  config.vm.provision "file", source: "mk-tarballs.sh", destination: "mk-tarballs.sh"
  # Instead of calling bootstrap-homedir.sh,
  config.vm.provision "shell", path: "install-ableC-bundle.sh", privileged: false
  config.vm.provision "shell", path: "install-cilk-libs.sh", privileged: false  


end
