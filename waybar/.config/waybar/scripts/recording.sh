#!/bin/sh

# wait for recording to start
sleep 1

if pgrep wl-screenrec > /dev/null; then
	printf "󰑊"
else
	printf ""
fi
