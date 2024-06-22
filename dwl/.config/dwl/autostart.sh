#!/bin/sh

batterynotif &
mpd-notify &
wlsunset -T 4001 -t 4000 &
swaybg --image "$XDG_DATA_HOME"/bg.jpg &

# setup screen locker
locker="waylock -fork-on-lock"
swayidle -w \
     timeout 900 "$locker" \
     timeout 910 'wlr-dpms off' \
     timeout 10 'if pgrep -x waylock; then wlr-dpms off; fi' \
     resume 'wlr-dpms on' \
     before-sleep "$locker"

# needed for systemd user services
systemctl --user import-environment WAYLAND_DISPLAY
