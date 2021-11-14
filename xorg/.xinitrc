#!/bin/sh
#
# vim:    set ft=sh tw=0:
# file:   ~/.xinitrc
# author: Brian Buccola

display-adjust
keyboard-adjust
~/.fehbg
xrdb -merge ~/.Xresources
xset s 300 300
xautolock -time 5 -locker slock &

while true; do
    ${HOME}/repos/scripts/dwmstatus
    sleep 1
done &

exec xmonad
