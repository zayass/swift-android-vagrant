# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  # tested version
  # config.vm.box_version = "20170317.0.0"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  if ENV.has_key? 'VAGRANT_SHARED_FOLDER'
    puts "Host folder: #{ENV['VAGRANT_SHARED_FOLDER']} will be mounted to guest: ~/shared"
    config.vm.synced_folder ENV['VAGRANT_SHARED_FOLDER'], "/home/ubuntu/shared"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 4
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  config.vm.provision "shell", path: "provision/010_install_dependencies.sh"
  config.vm.provision "shell", path: "provision/020_install_ndk.sh", privileged: false
  config.vm.provision "shell", path: "provision/030_install_prebuilt_swift.sh", privileged: false
  config.vm.provision "shell", path: "provision/040_install_android_ld.sh"
  config.vm.provision "shell", path: "provision/050_johnno_home_fix.sh"
  config.vm.provision "shell", path: "provision/060_collect_libraries.sh", privileged: false
end
