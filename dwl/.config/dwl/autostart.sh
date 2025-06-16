#!/bin/sh

batterynotif &
wlsunset -T 4001 -t 4000 &
swaybg --image "$XDG_DATA_HOME"/bg.jpg &
udiskie -q &
# dwmbar &

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
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# dwlb -font "JetBrainsMono Nerd Font:size=11" \
# 	-active-fg-color "#191724" -active-bg-color "#C4A7E7" \
# 	-middle-bg-color-selected "#C4A7E7" -middle-bg-color "#191724" \
# 	-occupied-bg-color "#191724" -occupied-fg-color "#E0DEF4" \
# 	-inactive-bg-color "#191724" -inactive-fg-color "#E0DEF4" \
# 	-urgent-fg-color "#191724" -urgent-bg-color "#E0DEF4"
