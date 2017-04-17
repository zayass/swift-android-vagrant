# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "zayass/swift-android"

  if ENV.has_key? 'VAGRANT_SHARED_FOLDER'
    puts "Host folder: #{ENV['VAGRANT_SHARED_FOLDER']} will be mounted to guest: ~/shared"
    config.vm.synced_folder ENV['VAGRANT_SHARED_FOLDER'], "/home/vagrant/shared"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 4
  end
end
