#!/bin/bash

cp /vagrant/configs/51-android.rules /etc/udev/rules.d/
udevadm control --reload-rules
udevadm trigger
service udev restart
apt-get install android-tools-adb
