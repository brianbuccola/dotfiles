#!/bin/sh

# vim:      set ft=sh sw=4 et nu fenc=utf-8:
# file:     ~/.xinitrc
# author:   Brian Buccola


$HOME/scripts/display-adjust.sh         # auto-adjust monitors
xrdb -merge $HOME/.Xresources           # add .Xresources to database
xset fp+ /usr/share/fonts/local         # add local fonts to fontpath
$HOME/scripts/keyboard-adjust.sh        # add kbd layouts, switch ctrl/caps
xsetroot -cursor_name left_ptr          # change default ugly pointer
eval $(cat "$HOME/.fehbg")              # set background
urxvtd -q -f -o &                       # urxvt terminal daemon
syndaemon -t -k -i 2 -d &               # disable touchpad while typing
unclutter &                             # make idle cursor disappear
xscreensaver -no-splash &               # load screensaver
wmname LG3D                             # fix JabRef/Java apps

xmonad                                  # start xmonad
