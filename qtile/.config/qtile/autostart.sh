#!/usr/bin/env bash 

picom --fade-in-step=1 --fade-out-step=1 --fade-delta=0 &
conky -c $HOME/.config/conky/qtile/gruvbox-dark-01.conkyrc
nm-applet &
fcitx5 -d

nitrogen --restore &
