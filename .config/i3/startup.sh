#!/bin/sh

i3-msg "workspace 1; append_layout /home/ghetto/.config/i3/ws-main.json" &
firefox &
emacs &
urxvt &
