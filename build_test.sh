#!/bin/bash

DIR=`dirname $0`

swiftc \
    -target armv7-none-linux-androideabi \
    -sdk $ANDROID_NDK/platforms/android-21/arch-arm \
    -L $ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a \
    -L $ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/lib/gcc/arm-linux-androideabi/4.9.x \
    -I $ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/lib/gcc/arm-linux-androideabi/4.9.x/include \
    -emit-executable \
    -Xlinker -pie \
    $DIR/test.swift
