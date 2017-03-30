#!/bin/bash

source .profile

pushd $SWIFT_SOURCE

	pushd swift-corelibs-libdispatch
	
		git apply /vagrant/patches/libdispatch.patch

		sh autogen.sh
		env \
			CC="$SWIFT_BUILDPATH/llvm-linux-x86_64/bin/clang" \
			CXX="$SWIFT_BUILDPATH/llvm-linux-x86_64/bin/clang++" \
			SWIFTC="$SWIFT_BUILDPATH/swift-linux-x86_64/bin/swiftc" \
			LDFLAGS="-L$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/arm-linux-androideabi/lib/ -latomic" \
			./configure \
				--with-swift-toolchain="$SWIFT_HOME" \
				--with-build-variant=release \
				--enable-android \
				--host=arm-linux-androideabi \
				--with-android-ndk=$ANDROID_NDK \
				--with-android-api-level=21 \
				--disable-build-tests

		make
		make install

	popd

popd
