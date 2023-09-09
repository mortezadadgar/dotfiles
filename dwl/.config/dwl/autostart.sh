#!/bin/sh

start() {
	pgrep "$1" || "$@" &
}

start batterynotif
start mako
start dwmbar
start swaybg --image "$XDG_DATA_HOME"/bg.jpg
start mpd-notify
start wlsunset -T 6000 -t 5500
start swayidle -w \
     timeout 900 'waylock -fork-on-lock' \
     before-sleep 'waylock -fork-on-lock'

exec somebar
