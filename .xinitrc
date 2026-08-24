#!/bin/bash
#export GTK_THEME=Nightmare
#export XDG_CURRENT_DESKTOP=generic
xrandr --output eDP-1 --scale 0.5x0.5
xrdb ~/.Xresources
#dbus-launch --sh-syntax --exit-with-session dwm
cd /mnt/FASTstorage/FASTprogs/utils
rm .tmp_pids
bash start_all_services.sh&
exec dwm
#exec openbox

