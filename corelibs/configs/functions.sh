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

adb_push() {
	unamestr=`uname`
	if [[ "$unamestr" == 'Darwin' ]]; then
		adb push "$@"
		return $?
	fi

	local src=${@:1:$#-1}
	local dst=${@:$#}

	for file in $src
	do
		adb push $file $dst
	done
}

lldb_xctest() {
	local port=1234
	local test_runner=$(find . -name '*.xctest' -exec basename {} \;)

	local unamestr=`uname`
	local args=
	local source_map=

	if [[ $# -ne 0 ]]; then
		args="settings set -- target.run-args '$@'"
	fi

	if [[ "$unamestr" == 'Darwin' ]]; then
		source_map="settings append target.source-map /home/vagrant/shared $VAGRANT_SHARED_FOLDER"
	fi

	nohup adb shell '/data/local/tmp/lldb-server platform --server --listen *:'$port &
	sleep 3

	echo > .lldb_script
	echo "platform select remote-android"             >> .lldb_script
	echo "platform settings -w /data/local/tmp"       >> .lldb_script
	echo "platform connect connect://localhost:$port" >> .lldb_script
	echo "target create /data/local/tmp/$test_runner" >> .lldb_script
	echo "target stop-hook add -n tgkill -o 'f 3'"    >> .lldb_script
	echo "$args"                                      >> .lldb_script
	echo "$source_map"                                >> .lldb_script
	echo "platform settings -w /data/local/tmp"       >> .lldb_script
	echo "env LD_LIBRARY_PATH=/data/local/tmp"        >> .lldb_script
	
	lldb -S .lldb_script

	kill $!
	rm .lldb_script
	rm nohup.out
}
