#!/bin/bash

source .profile

git clone https://github.com/SwiftAndroid/libiconv-libicu-android.git libiconv-libicu-android

pushd ./libiconv-libicu-android 
	./build.sh
popd

echo 'export LIBICONV_ANDROID="'`realpath ./libiconv-libicu-android`'"' >> .profile