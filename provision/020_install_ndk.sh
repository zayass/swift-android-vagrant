#!/bin/bash
NDK=android-ndk-r13b
NDK_ZIP=$NDK-linux-x86_64.zip

wget --progress=bar:force https://dl.google.com/android/repository/$NDK_ZIP
unzip $NDK_ZIP
rm $NDK_ZIP

pushd $NDK
	pushd toolchains
		rm -r aarch64-linux-android-4.9 mips64el-linux-android-4.9 mipsel-linux-android-4.9 x86-4.9 x86_64-4.9
	popd

	pushd platforms
		rm -r android-9 android-12 android-13 android-14 android-15 android-17 android-18 android-19 android-22 android-23 android-24
	popd
popd

NDK=`realpath $NDK`

echo 'export ANDROID_NDK="$NDK"' >> .profile
echo 'export PATH="$ANDROID_NDK:$PATH"' >> .profile