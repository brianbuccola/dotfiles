#!/bin/sh
#
# vim:    set ft=sh tw=0:
# file:   ~/.xinitrc
# author: Brian Buccola

display-adjust
keyboard-adjust
touchpad-toggle
xrdb -merge ~/.Xresources
~/.fehbg
xautolock -time 5 -locker i3lock-blur &
compton &

while true; do
    ${HOME}/repos/scripts/dwmstatus
    sleep 1
done &

while true; do
    /usr/bin/dwm 2> ~/.dwm.log
done
