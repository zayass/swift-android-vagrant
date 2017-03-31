#!/bin/bash

source .profile.tmp

pushd $SWIFT_LIB
	include=.
	so=android
	swift=android/armv7

	# icu
	cp $LIBICONV_ANDROID/armeabi-v7a/*.so $so

	# foundation dependencies
	# curl
	cp -r $ANDROID_STANDALONE_TOOLCHAIN/sysroot/usr/include/curl $include
	cp $ANDROID_STANDALONE_TOOLCHAIN/sysroot/usr/lib/libcurl.so $so
	# libxml
	cp -r $ANDROID_STANDALONE_TOOLCHAIN/sysroot/usr/include/libxml2/libxml $include
	cp $ANDROID_STANDALONE_TOOLCHAIN/sysroot/usr/lib/libxml2.so $so

	# dispatch
	cp -r /usr/local/lib/swift/dispatch $include
	cp /usr/local/lib/swift/android/libdispatch.so $so
	cp /usr/local/lib/swift/android/armv7/Dispatch.swiftmodule $swift

	# foundation
	foundation_build=$SWIFT_BUILDPATH/foundation-linux-x86_64/Foundation
	cp -r $foundation_build/usr/lib/swift/CoreFoundation $include
    cp $foundation_build/libFoundation.so $so
    cp $foundation_build/Foundation.swiftmodule $swift
popd