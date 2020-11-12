#!/bin/bash

selected=$(echo -e " Restart\n Shutdown" | rofi -dmenu -width 9 -theme ~/.config/rofi/power.rasi -p "PowerMenu")

echo "$selected"

if [ "$selected" == " Shutdown" ]; then
				off_selected=$(echo -e "  Yes\n  No" | rofi -dmenu -width 8 -theme ~/.config/rofi/power.rasi -p "Shutdown")
				if [ "$off_selected" == "  Yes" ]; then
								poweroff
								echo 'poweroff'
				else
								exit
				fi
fi

if [ "$selected" == " Restart" ]; then
				res_selected=$(echo -e "  Yes\n  No" | rofi -dmenu -width 8 -theme ~/.config/rofi/power.rasi -p "Restart")
				if [ "$res_selected" == "  Yes" ]; then
								reboot
								exit
				else
								exit
				fi
fi
