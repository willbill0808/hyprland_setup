#!/bin/bash

status "Started downloading with dependencies"

cd ~

sudo pacman -S gnome-keyring \
  hyprlock hypridle hyprpaper waybar  \
  nautilus vscode rofi --noconfirm

sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk  xdg-desktop-portal-hyprland --noconfirm

status "Done with dependencies"
