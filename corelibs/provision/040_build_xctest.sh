#!/bin/bash

source .profile.tmp
source /vagrant/functions.sh

src=$SWIFT_SOURCE/swift-corelibs-xctest
build_dir=$SWIFT_BUILDPATH/xctest-linux-x86_64

pushd $src

	git apply /vagrant/patches/xctest.patch
	# for release build
	#
	# name=XCTest
	#
	# swift_android \
	# 	-c -O \
	# 	-force-single-frontend-invocation \
	# 	\
	# 	-emit-module -emit-module-path "$build_dir/$name.swiftmodule" \
	# 	-module-name $name -module-link-name $name \
	# 	\
	# 	-emit-object -o "$build_dir/$name.o" \
	# 	`find_swift_sources Sources`
	#
	# swift_android \
	# 	-emit-library -o $build_dir/lib$name.so \
	# 	-Xlinker -soname=lib$name.so \
	# 	$build_dir/$name.o

	build_swift_module XCTest $build_dir \
		`find_swift_sources Sources`
popd

pushd $build_dir
	cp libXCTest.so $SWIFT_LIB/android
	cp XCTest.swiftmodule $SWIFT_LIB/android/armv7
popd