#!/bin/sh
set -eu

if [ "$(amixer get Capture | grep -cm1 "\[on\]")" = "0" ]; then
	printf " "
else
	printf ""
fi
