#!/usr/bin/env bash

# initializing wallpaper
swaybg -i ~/configs/wallpaper.jpg &

# notification manager
mako &

# initialize bar
waybar -c ~/configs/.config/waybar/hyprland-config &
