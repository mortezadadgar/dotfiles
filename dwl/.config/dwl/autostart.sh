#!/bin/sh

start() {
	pgrep "$1" || "$@" &
}

start batterynotif
start dwmbar
start mpd-notify
start swaybg --image "$XDG_DATA_HOME"/bg.jpg
start swayidle -w \
     timeout 900 'waylock -fork-on-lock' \
     before-sleep 'waylock -fork-on-lock'

# should be started on every login
gammastep -O 5500 &

# needed for systemd user services
systemctl --user import-environment WAYLAND_DISPLAY &

exec somebar
