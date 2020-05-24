#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch topbar
polybar top -r &
