#!/bin/bash

JOHNNO_HOME=/home/johnno

mkdir $JOHNNO_HOME
ln -s $ANDROID_NDK $JOHNNO_HOME/`basename $ANDROID_NDK`
