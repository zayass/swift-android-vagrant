#!/bin/bash

source .profile.tmp

pushd $SWIFT_SOURCE
	# ls | grep -v '^build$'| xargs rm -rf

	# pushd build/Ninja-ReleaseAssert
	# 	ls | grep -v '^swift-linux-x86_64$' | xargs rm -rf
	# popd
popd

rm -rf $LIBICONV_ANDROID
rm -rf $ANDROID_STANDALONE_TOOLCHAIN
rm -rf /usr/local/lib/swift


echo "export ANDROID_NDK=\"$ANDROID_NDK\"" >> .profile
echo "export SWIFT_HOME=\"$SWIFT_HOME\"" >> .profile
echo "export SWIFT_LIB=\"$SWIFT_LIB\"" >> .profile

echo 'export PATH="$SWIFT_HOME/bin:$ANDROID_NDK:$PATH"' >> .profile
echo 'export EDITOR=vim' >> .profile

rm .profile.tmp

echo >> .bashrc
echo >> .bashrc
cat /vagrant/functions.sh >> .bashrc
cat /vagrant/functions.sh | grep '()' | grep -o '\w*' | xargs -L 1 echo export -f >> .bashrc