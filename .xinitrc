#!/bin/bash
#export GTK_THEME=Nightmare
#export XDG_CURRENT_DESKTOP=generic
xrandr --output eDP1 --scale 0.5x0.5 --output HDMI2 --auto --right-of eDP1
xrdb ~/.Xresources
cd /mnt/FASTstorage/FASTprogs/utils
rm .tmp_pids
#bash start_all_services.sh&
#dbus-launch --sh-syntax --exit-with-session dwm
exec dwm
#exec openbox

