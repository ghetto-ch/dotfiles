#!/bin/sh

i3-msg "workspace 9; append_layout /home/ghetto/.config/i3/ws-term.json" &
st -t htop htop &
st -t sensors watch -n 5 sensors &
#st -t iostat watch -n 5 iostat &
#st -t gpu sudo radeontop &
sleep 1
i3-msg "workspace 1; append_layout /home/ghetto/.config/i3/ws-main.json" &
firefox &
emacs &
st &
