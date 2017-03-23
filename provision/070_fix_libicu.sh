#!/bin/bash

pushd libs
	rpl -R -e libicu libscu libswift*.so
	rpl -R -e libicu libscu libFoundation.so
	rpl -R -e libicudata libscudata libicuuc.so 
	rpl -R -e libicudata libscudata libicui18n.so 
	rpl -R -e libicuuc libscuuc libicui18n.so 

	mv libicudata.so libscudata.so 
	mv libicuuc.so libscuuc.so 
	mv libicui18n.so libscui18n.so
popd
