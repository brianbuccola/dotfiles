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

while true; do
    tmux has-session -t mutt || st -c mutt -e tmux new -s mutt mutt &
    tmux has-session -t scratchpad || st -c scratchpad -e tmux new -s scratchpad &
    tmux has-session -t work || st -c work -e tmux new -s work &
    /usr/bin/dwm 2> ~/.dwm.log
done
