#!/bin/bash
alacritty -e sh -c "sudo pacman -Syu; pkill -SIGRTMIN+8 waybar"
