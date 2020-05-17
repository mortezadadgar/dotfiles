#!/usr/bin/env bash
#
# cpufreq.sh
# Author: 	Alex Paarfus <stewie410@gmail.com>
#
# Reports the average CPU Frequency

# Get frequency
command -v cpupower >/dev/null || return
cpupower frequency-info --freq --human | \
    awk '/current/ {print $4$5}'
