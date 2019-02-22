#!/bin/sh
#
# vim:    set ft=sh tw=0:
# file:   ~/.xinitrc
# author: Brian Buccola

display-adjust
keyboard-adjust
~/.fehbg
touchpad-toggle
xrdb -merge ~/.Xresources
xset s 300 300
xautolock -time 5 -locker slock &

exec xmonad
