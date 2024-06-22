if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	dwmbar | (exec dwl -s "$HOME/.config/dwl/autostart.sh" 2>~/dwl.log)
fi
