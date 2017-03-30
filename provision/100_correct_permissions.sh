#!/bin/bash

user=$(basename $(pwd))
chown $user:$user -R .