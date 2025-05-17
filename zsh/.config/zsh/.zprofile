if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec dwl -s "$HOME/.config/dwl/autostart.sh" 2>/dev/null
fi
