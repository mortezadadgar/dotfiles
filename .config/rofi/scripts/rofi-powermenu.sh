#!/bin/bash


if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1f/usr/share/icons/Papirus/48x48/apps/system-shutdown.svg\n"
    echo -en "Reboot\0icon\x1f/usr/share/icons/Papirus/48x48/apps/system-reboot.svg\n"
    echo -en "Logout\0icon\x1f/usr/share/icons/Papirus/48x48/apps/system-log-out.svg\n"
    echo -en "Lock\0icon\x1f/usr/share/icons/Papirus/48x48/apps/system-lock-screen.svg\n"
    echo -en "Suspend\0icon\x1f/usr/share/icons/Papirus/48x48/apps/system-suspend.svg\n"
else
    if [ "$1" = "Shutdown" ]; then
        shutdown now
    elif [ "$1" = "Logout" ]; then
        bspc quit
    elif [ "$1" = "Reboot" ]; then
        reboot
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    elif [ "$1" = "Lock" ]; then
        dm-tool lock
    fi
fi
