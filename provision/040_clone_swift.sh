#!/bin/bash

source .profile

TAG="swift-3.1-RELEASE"

mkdir -p swift-source/swift
git clone https://github.com/apple/swift.git swift-source/swift

pushd swift-source
	swift/utils/update-checkout --clone
	swift/utils/update-checkout --tag $TAG
popd

echo 'export SWIFT_SOURCE="'`realpath ./swift-source`'"' >> .profile