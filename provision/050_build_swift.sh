#!/bin/bash

source .profile

pushd $SWIFT_SOURCE/swift
	utils/build-script \
		-R \
		--android \
		--android-ndk $ANDROID_NDK \
		--android-api-level 21 \
		--android-icu-uc $LIBICONV_ANDROID/armeabi-v7a \
		--android-icu-uc-include $LIBICONV_ANDROID/armeabi-v7a/icu/source/common \
		--android-icu-i18n $LIBICONV_ANDROID/armeabi-v7a \
		--android-icu-i18n-include $LIBICONV_ANDROID/armeabi-v7a/icu/source/i18n \
		--llbuild \
		--lldb \
		--swiftpm \
		--xctest
popd

echo 'export SWIFT_BUILDPATH="$SWIFT_SOURCE/build/Ninja-ReleaseAssert"' >> .profile
echo 'export SWIFT_HOME="$SWIFT_BUILDPATH/swift-linux-x86_64"' >> .profile
echo 'export SWIFT_LIB="$SWIFT_HOME/lib/swift"' >> .profile

echo 'export PATH="$SWIFT_HOME/bin:$PATH"' >> .profile