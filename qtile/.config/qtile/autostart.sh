#!/usr/bin/env bash 

# picom &
conky -c $HOME/.config/conky/qtile/gruvbox-dark-01.conkyrc
nm-applet &

nitrogen --restore &
