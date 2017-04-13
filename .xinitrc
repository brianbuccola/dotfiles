#!/bin/sh
#
# vim:    set ft=sh tw=0:
# file:   ~/.xinitrc
# author: Brian Buccola

display-adjust
keyboard-adjust
touchpad-toggle
xrdb -merge ~/.Xresources
xset s on +dpms                    # make screen blank after 10m of inactivity (default)
xautolock -time 10 -locker slock & # lock screen (with slock) after 10m of inactivity
xmonad &> ~/.xmonad/log
