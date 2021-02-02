# Enable Echo Cancellation
pactl load-module module-echo-cancel use_master_format=1 aec_method=webrtc \
	aec_args="analog_gain_control=0\ digital_gain_control=1" \
	source_name=echoCancel_source sink_name=echoCancel_sink
pacmd set-default-source echoCancel_source
pacmd set-default-sink echoCancel_sink

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
