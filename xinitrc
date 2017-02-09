#!/bin/sh

# vim:      set ft=sh sw=4 et nu fenc=utf-8:
# file:     ~/.xinitrc
# author:   Brian Buccola

${HOME}/repos/scripts/display-adjust.sh     # auto-adjust monitors
xrdb -merge ${HOME}/.Xresources             # add .Xresources to database
${HOME}/repos/scripts/keyboard-adjust.sh    # add kbd layouts, switch ctrl/caps
xsetroot -cursor_name left_ptr              # change default ugly pointer
${HOME}/.fehbg                              # set background
urxvtd -q -f -o                             # urxvt terminal daemon
xset s on +dpms                             # make screen blank after 10m of inactivity (default)
xautolock -time 10 -locker slock &          # lock screen (with slock) after 10m of inactivity

xmonad &> ${HOME}/.xmonad/log               # start xmonad
