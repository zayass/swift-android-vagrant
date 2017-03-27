#!/bin/bash

wget --progress=bar:force https://dl.dropboxusercontent.com/s/1dz1shrmqrwo16w/android_toolchain.tgz
tar -xvzf android_toolchain.tgz
rm android_toolchain.tgz

SWIFT=`realpath swift/build/Ninja-ReleaseAssert/swift-linux-x86_64/`

echo 'export SWIFT="'$SWIFT'"' >> .profile
echo 'export PATH="$SWIFT/bin:$PATH"' >> .profile
