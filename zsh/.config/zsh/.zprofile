# LS_COLORS
(( $+commands[dircolors] )) && eval `dircolors`

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi
