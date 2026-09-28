#!/bin/bash
#export GTK_THEME=Nightmare
#export XDG_CURRENT_DESKTOP=generic
xrandr --output eDP-1 --scale 0.5x0.5 --output HDMI-2 --auto --right-of eDP-1
xrdb ~/.Xresources
cd /mnt/FASTstorage/FASTprogs/utils
rm .tmp_session_names_file
bash start_all_services.sh&
#dbus-launch --sh-syntax --exit-with-session dwm
exec dwm
#exec openbox
