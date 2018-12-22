#!/bin/sh

i3-msg "workspace 1; append_layout /home/ghetto/.config/i3/ws-main.json" &
i3-msg "workspace 8; append_layout /home/ghetto/.config/i3/ws-htop.json" &
i3-msg "workspace 9; append_layout /home/ghetto/.config/i3/ws-term.json" &
sleep 0.1
st -t htop htop &
st -t files ranger &
#st -f "DejaVu Sans Mono for Powerline:pixelsize=15" -t sensors watch -n 5 "sensors | awk '/^fan|^Tdie/'" &
#st -t iostat watch -n 5 iostat &
#st -t gpu sudo radeontop &
#st -f "DejaVu Sans Mono for Powerline:pixelsize=12" -t gpu watch -n 5 nvidia-smi &
sleep 0.1

qutebrowser &
emacs &
st &
