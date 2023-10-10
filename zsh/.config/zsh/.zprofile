if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
	# while true; do
	# 	exec dwl -s '$XDG_CONFIG_HOME/dwl/autostart.sh'
	# done
fi
