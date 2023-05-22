#!/bin/sh
#
# vim:    set ft=sh tw=0:
# file:   ~/.xinitrc
# author: Brian Buccola

display-adjust
keyboard-adjust
~/.fehbg
xrdb -merge ~/.Xresources
xset s off
xset -dpms

exec ~/.xmonad/xmonad-x86_64-linux
