#!/bin/bash

source .profile.tmp

TAG="swift-3.1-RELEASE"

mkdir -p swift-source/swift
git clone https://github.com/apple/swift.git swift-source/swift

pushd swift-source/swift
	git checkout $TAG

	utils/update-checkout --clone
	# remove generated python bytcode from outdated sources
	find . -name '*.pyc' -exec rm {} \;

	utils/update-checkout --tag $TAG
	# remove generated python bytcode from outdated sources
	find . -name '*.pyc' -exec rm {} \;
popd

echo 'export SWIFT_SOURCE="'`realpath ./swift-source`'"' >> .profile.tmp
