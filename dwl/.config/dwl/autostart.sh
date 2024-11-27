#!/bin/sh

batterynotif &
wlsunset -T 5001 -t 5000 &
swaybg --image "$XDG_DATA_HOME"/bg.jpg &
udisksd -q &

# setup screen locker
locker="waylock -fork-on-lock"
swayidle -w \
     timeout 900 "$locker" \
     timeout 910 'wlr-dpms off' \
     resume 'wlr-dpms on' \
     before-sleep "$locker" &

# needed for systemd user services
systemctl --user import-environment WAYLAND_DISPLAY
