#!/bin/sh

start() {
	pkill "$1" && pwait "$1"
	"$@" &
}

start batterynotif
start mako
start dwmbar
start syncthing --no-browser >/dev/null 2>&1
start swaybg --image "$XDG_DATA_HOME"/bg.jpg
start mpd
sleep 0.5
start mpd-notify
start gammastep -PO 5500

pkill pipewire; pwait pipewire; gentoo-pipewire-launcher &
swayidle -w \
     timeout 900 'waylock -fork-on-lock' \
	 timeout 910 'loginctl suspend' \
     before-sleep 'waylock -fork-on-lock' &

exec somebar
