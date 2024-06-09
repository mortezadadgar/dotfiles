#!/bin/sh

start() {
	pgrep "$1" || "$@" >/dev/null 2>&1 &
}

start batterynotif
start mpd-notify
start swaybg --image "$XDG_DATA_HOME"/bg.jpg
start swayidle -w \
     timeout 900 'waylock -fork-on-lock' \
     before-sleep 'waylock -fork-on-lock'

# should be started on every login
wlr-randr --output HDMI-A-1 --mode 1920x1080@74.973
gammastep -O 4000 &

# needed for systemd user services
systemctl --user import-environment WAYLAND_DISPLAY &
