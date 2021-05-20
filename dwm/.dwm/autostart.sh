#!/bin/sh
# Programs to run in the background:
nm-applet &
sxhkd &
wal -R &
( cd $HOME/.dwm/ && dwmblocks) &

# Some other declarations:
amixer set Master 0 &
xsetroot -cursor_name left_ptr &

# Launch scripts:
cd $HOME/.dwm/ && if script_lnchr.sh -s "$(cat ./scripts.txt)"; then notify-send "Scripts successfully started" -u normal ; fi

# Compositor:
killall -wq -s KILL picom
hst-chk.sh Laptop && picom --blur-background -b
hst-chk.sh PC && picom --backend xrender --no-vsync --blur-background -b
