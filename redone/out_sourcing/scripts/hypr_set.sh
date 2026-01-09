#!/bin/bash

cd ~/Documents/hyprland_setup/redone/out_sourcing

mkdir -p ~/.config/hypr
cp hyprland.conf hyprlock.conf hyprpaper.conf ~/.config/hypr/

mkdir -p ~/.config/kitty
cp terminal/kitty.conf ~/.config/kitty/

cd ~
git clone https://github.com/adi1090x/rofi.git

cd rofi/files
mkdir -p ~/.config/rofi
cp -r colors config.rasi launchers ~/.config/rofi
cd ~/Documents/hyprland_setup/redone/out_sourcing
cp launcher.sh ~/.config/rofi/launchers/type-2
cp denji.rasi ~/.config/rofi/colors
cp -r shared ~/.config/rofi/launchers/type-2

cd ~