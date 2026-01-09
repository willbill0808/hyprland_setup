#!/bin/bash

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si --noconfirm
cd ..

yay -S librewolf-bin github-desktop --noconfirm