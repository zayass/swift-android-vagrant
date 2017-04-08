#!/bin/bash

source .profile.tmp

OUT="libs/"

LIB_CPP="$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_shared.so"

SWIFT_LIBS=(
'libicudata.so'
'libicui18n.so'
'libicuuc.so'
'libswiftGlibc.so'
'libswiftCore.so'
'libswiftSwiftOnoneSupport.so'
'libdispatch.so'
'libcurl.so'
'libxml2.so'
'libFoundation.so'
'libXCTest.so'
)

mkdir -p $OUT
for lib in ${SWIFT_LIBS[*]}
do
	cp "$SWIFT_LIB/android/$lib" $OUT
done

cp $LIB_CPP $OUT

cp -r $OUT /vagrant
