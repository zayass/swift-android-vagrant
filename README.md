# swift-android-vagrant

Based on prebuilt swift-android from https://github.com/apple/swift-corelibs-foundation/tree/master/android

## Vagrant

Install vagrant from https://www.vagrantup.com/

## Usage
Each command should be invoked in repository root
You can define ```VAGRANT_SHARED_FOLDER``` environment variable before ```vagrat up``` to mount some specific folder on host to guest ~/shared

Download and provision image
```
vagrant up
```

Connect to vm
```
vagrant ssh
```

Required shared libraries collected to ```~/libs```
