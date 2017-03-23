#!/bin/bash

env

ln -s $ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-ld.gold /usr/bin/armv7-none-linux-android-ld.gold
ln -s $ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-ld.gold /usr/bin/armv7-none-linux-androideabi-ld.gold
