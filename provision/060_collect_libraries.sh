#!/bin/bash

source .profile

OUT="libs/"

LIB_CPP="$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_shared.so"
SWIFT_LIB=$SWIFT/lib/swift/android/


SWIFT_LIBS=(
'libFoundation.so'
'libdispatch.so'
'libicudata.so'
'libicui18n.so'
'libicuuc.so'
'libswiftCore.so'
'libswiftGlibc.so'
'libswiftSwiftOnoneSupport.so'
'libxml2.so'
'libcurl.so'
)

mkdir -p $OUT
for lib in ${SWIFT_LIBS[*]}
do

	cp "$SWIFT_LIB/$lib" $OUT
done

cp $LIB_CPP $OUT
