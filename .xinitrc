#!/bin/sh
#
# vim:    set ft=sh tw=0:
# file:   ~/.xinitrc
# author: Brian Buccola

display-adjust
keyboard-adjust
~/.fehbg
compton -b
touchpad-toggle
xrdb -merge ~/.Xresources
xset s 300 300
xautolock -time 5 -locker slock &

# exec xmonad

while true; do
    ${HOME}/repos/scripts/dwmstatus
    sleep 1
done &

while true; do
    tmux has-session -t scratchpad || st -n scratchpad -e tmux new -s scratchpad &
    tmux has-session -t work || st -n work -e tmux new -s work &
    /usr/bin/dwm 2> ~/.dwm.log
done
