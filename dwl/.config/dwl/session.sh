#!/bin/sh

export XDG_CURRENT_DESKTOP="dwl"

# reset failed state of all user units
systemctl --user reset-failed

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user start dwl-session.target

# shutdown session on SIGTERM signal
shutdown() {
    systemctl --user start --job-mode=replace-irreversibly dwl-session-shutdown.target
}
trap shutdown TERM

# wait for dwl to exit
tail --pid="$(pgrep -x dwl)" -f /dev/null
