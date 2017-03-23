#!/bin/bash
mkdir -p swift/build
pushd swift/build
	wget https://dl.dropboxusercontent.com/s/1dz1shrmqrwo16w/android_toolchain.tgz --no-verbose 
	tar -xvzf android_toolchain.tgz
	rm android_toolchain.tgz

	SWIFT_BIN=`realpath Ninja-ReleaseAssert/swift-linux-x86_64/bin/`
	echo 'export PATH="'$SWIFT_BIN':$PATH"' >> $HOME/.profile
popd
