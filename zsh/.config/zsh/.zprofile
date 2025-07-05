if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec dwl -s "$HOME/.config/dwl/session.sh"
fi
