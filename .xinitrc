# X settings
xset -dpms &
xset s 420 10 &
xset r rate 300 30 &
xsetroot -cursor_name left_ptr &
setxkbmap -layout us,ir -option grp:alt_shift_toggle &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Natural Scrolling Enabled" 1 &
xwallpaper --stretch $HOME/.config/wallp.jpg &

# Autostart
redshift -t 5000:4000 -l 35:51 > /dev/null &
picom --experimental-backends &
xss-lock -n dim-screen -l -- slock &
batterynotif &
dunst &
mpd &
udiskie -sq &
polybar top -rq &

# WM
sxhkd &
exec bspwm
