#!/bin/bash
export GTK_THEME=Nightmare
export XDG_CURRENT_DESKTOP=generic
xrandr --output eDP-1 --scale 0.6x0.6
xrdb ~/.Xresources
dbus-launch --sh-syntax --exit-with-session dwm
#exec openbox

