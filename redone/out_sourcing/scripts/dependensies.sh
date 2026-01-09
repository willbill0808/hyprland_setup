#!/bin/bash

sudo pacman -Suy zsh base-devel git gnome-keyring \
  hyprlock hypridle hyprpaper waybar  \
  nautilus vscode rofi --noconfirm

sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk  xdg-desktop-portal-hyprland --noconfirm