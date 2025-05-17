#!/bin/sh

batterynotif &
wlsunset -T 4001 -t 4000 &
swaybg --image "$XDG_DATA_HOME"/bg.jpg &
udiskie -q &
waybar --log-level off &
xrdb -merge "$XDG_CONFIG_HOME"/x11/Xresources & # useful for nsxiv

# setup screen locker
locker="waylock -fork-on-lock"
swayidle -w \
     timeout 900 "$locker" \
     timeout 910 'wlr-dpms off' \
     resume 'wlr-dpms on' \
     timeout 15 'if pgrep waylock >/dev/null; then wlr-dpms off; fi' \
     resume 'if pgrep waylock >/dev/null; then wlr-dpms on; fi' \
     before-sleep "$locker" &

# polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# needed for systemd user services
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP FZF_DEFAULT_OPTS PATH
