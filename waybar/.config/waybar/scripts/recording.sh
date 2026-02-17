#!/bin/sh

# wait for recording to start
sleep 1

if pgrep wf-recorder > /dev/null; then
	printf "󰑊"
else
	printf ""
fi
