swift_android() {
	swiftc -v \
		-target armv7-none-linux-androideabi \
		-sdk $ANDROID_NDK/platforms/android-21/arch-arm \
		-L $ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a \
		-L $ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/lib/gcc/arm-linux-androideabi/4.9.x \
		"$@"
}

find_swift_sources() {
	find "$1" -name '*.swift'
}

build_swift_module() {
	local name=$1
	shift
	local build_dir=$1
	shift

	swift_android \
		-emit-module -emit-module-path "$build_dir/$name.swiftmodule" \
		-module-name $name -module-link-name $name \
		\
		-emit-library -o "$build_dir/lib$name.so" \
		-Xlinker -soname=lib$name.so \
		"$@"
}

build_swift_executable() {
	swift_android \
		-emit-executable \
		-Xlinker -pie \
		"$@"
}
