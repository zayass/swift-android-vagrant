#!/bin/bash

source ~/.profile.tmp

export SYSROOT=$ANDROID_STANDALONE_TOOLCHAIN/sysroot
export PATH=$ANDROID_STANDALONE_TOOLCHAIN/bin:$PATH

pushd $SWIFT_SOURCE/swift-corelibs-foundation/

		env \
			SWIFTC="$SWIFT_BUILDPATH/swift-linux-x86_64/bin/swiftc" \
			CLANG="$SWIFT_BUILDPATH/llvm-linux-x86_64/bin/clang" \
			SWIFT="$SWIFT_BUILDPATH/swift-linux-x86_64/bin/swift" \
			SDKROOT="$SWIFT_BUILDPATH/swift-linux-x86_64" \
			BUILD_DIR="$SWIFT_BUILDPATH/foundation-linux-x86_64" \
			DSTROOT="/" \
			PREFIX="/usr/" \
			CFLAGS="-DDEPLOYMENT_TARGET_ANDROID -DDEPLOYMENT_ENABLE_LIBDISPATCH --sysroot=$ANDROID_NDK/platforms/android-21/arch-arm -I$LIBICONV_ANDROID/armeabi-v7a/include -I${SDKROOT}/lib/swift -I$ANDROID_NDK/sources/android/support/include -I$SYSROOT/usr/include -I$SWIFT_SOURCE/swift-corelibs-foundation/closure" \
			SWIFTCFLAGS="-DDEPLOYMENT_TARGET_ANDROID -DDEPLOYMENT_ENABLE_LIBDISPATCH -I$ANDROID_NDK/platforms/android-21/arch-arm/usr/include -L /usr/local/lib/swift/android -I /usr/local/lib/swift/android/armv7" \
			LDFLAGS="-fuse-ld=gold --sysroot=$ANDROID_NDK/platforms/android-21/arch-arm -L$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/lib/gcc/arm-linux-androideabi/4.9.x -L$LIBICONV_ANDROID/armeabi-v7a -L/usr/local/lib/swift/android -L$SYSROOT/usr/lib -ldispatch " \
			./configure \
				Release \
				--target=armv7-none-linux-androideabi \
				-DXCTEST_BUILD_DIR=$SWIFT_BUILDPATH/xctest-linux-x86_64 \
				-DLIBDISPATCH_SOURCE_DIR=$SWIFT_SOURCE/swift-corelibs-libdispatch \
				-DLIBDISPATCH_BUILD_DIR=$SWIFT_BUILDPATH/libdispatch-linux-x86_64

		# Prepend SYSROOT env variable to ninja.build script
		# SYSROOT is not being passed from build.py / script.py to the ninja file yet
		echo "SYSROOT=$SYSROOT" > build.ninja.new
		cat build.ninja >> build.ninja.new
		sed 's%\-rpath \\\$\$ORIGIN %%g' build.ninja.new > build.ninja
		rm build.ninja.new

		/usr/bin/ninja
popd
