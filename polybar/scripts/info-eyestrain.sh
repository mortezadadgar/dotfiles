#!/bin/sh

time=$((20 - $(date '+%-M') % 20))

if [ $time -eq 20 ]; then
    notify-send '20:20:20' &
fi

echo "$time"
