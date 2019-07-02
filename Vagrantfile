# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get update
    sudo apt install -y build-essential
    echo 'export PATH="/vagrant/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
  SHELL
end
