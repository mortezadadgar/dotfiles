#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  pulseaudio-ctl full-status |awk '{print $1}'
}

function is_mute {
  pulseaudio-ctl full-status |awk '{print $2}'
}

function send_notification {
  iconSound="org.kde.plasma.volume"
  iconMuted="notification-audio-volume-muted"
  if [ "$is_mute" = "yes" ]; then
    echo is_mute
    dunstify -i $iconMuted -r 2593 -u normal "mute"
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "━" 0 "$((volume / 5))" | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i $iconSound -r 2593 -u normal "   $bar"
    sleep 5
    dunstify -C 2593
  fi
}

case $1 in
  up)
    # volume up
    pulseaudio-ctl up
    send_notification
    ;;
  down)
    # volume down
    pulseaudio-ctl down
    send_notification
    ;;
  mute)
    # mute
    pulseaudio-ctl mute
    send_notification
    ;;
esac
