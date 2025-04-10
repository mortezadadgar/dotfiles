# change to ${WAYLAND_DISPLAY} for trying wayland
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	# dwmbar | exec dwl -s "$HOME/.config/dwl/autostart.sh" 2>>$HOME/.cache/dwl.log
	exec startx
fi
