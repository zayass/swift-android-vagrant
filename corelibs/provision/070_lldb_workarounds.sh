#!/bin/bash

source .profile.tmp

gcc_include=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/lib/gcc/arm-linux-androideabi/4.9.x/include
ndk_include=$ANDROID_NDK/platforms/android-21/arch-arm/usr/include

pushd $SWIFT_LIB
	for header in $gcc_include/*
	do
		ln -s $header $(basename $header)
	done

	for header in $ndk_include/*
	do
		if [ "$header" == "android" ]; then
			continue
		fi

		if [ "$header" == "linux" ]; then
			continue
		fi

		ln -s -f $header $(basename $header)
	done

	for header in $ndk_include/android/*
	do
		ln -s $header android/$(basename $header)
	done

	for header in $ndk_include/linux/*
	do
		ln -s $header linux/$(basename $header)
	done

    # already linked from android gcc. but looks dangerous
    unlink clang
popd

echo 'export LLDB_HOME="$SWIFT_BUILDPATH/lldb-linux-x86_64"' >> .profile.tmp
