xset r rate 300 30
setxkbmap -layout us,ir -option grp:alt_shift_toggle
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Natural Scrolling Enabled" 1
xsetroot -cursor_name left_ptr
xwallpaper --stretch $HOME/.config/wallp.jpg

exec bspwm
