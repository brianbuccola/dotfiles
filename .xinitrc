#!/bin/sh
#
# vim:    set ft=sh tw=0:
# file:   ~/.xinitrc
# author: Brian Buccola

display-adjust
keyboard-adjust
touchpad-toggle
xrdb -merge ~/.Xresources
xautolock -time 5 -locker i3lock-blur &
exec i3
