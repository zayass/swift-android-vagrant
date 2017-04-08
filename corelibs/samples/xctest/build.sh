#!/usr/bin/env bash

build_for_test() {
	local name=$1
	local build_dir=build
	local common_args="-L $build_dir -I $build_dir"

	mkdir -p $build_dir

	build_swift_module ${name} $build_dir \
		$common_args \
		-enable-testing \
		`find_swift_sources Sources`


	build_swift_module ${name}Tests $build_dir \
		$common_args \
		-enable-testing \
		`find_swift_sources Tests/${name}Tests`
		

	build_swift_excutable \
		$common_args \
		-o "$build_dir/${name}PackageTests.xctest" \
		"Tests/LinuxMain.swift"
		

	# remove intermediates
	rm $build_dir/*.swiftmodule
	rm $build_dir/*.swiftdoc
}


pushd $(realpath $(dirname $0))
	build_for_test "Calculator"
popd
