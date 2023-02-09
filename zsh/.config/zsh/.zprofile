if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx $XINITRC
  # exec river
  # exec dwl -s somebar
fi
