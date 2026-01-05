#!/usr/bin/env fish

cd $HOME

#base stuff
sudo pacman -Syu unzip nautilus vscode rofi gnome-keyring base-devel git --noconfirm

#exit sudo(super user)
exit

#snap
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si

sudo systemctl enable --now snapd.socket

#exit sudo(super user)
exit
cd ..

#yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#yay stuff
yay -S github-desktop

cd ..

#snap stuff
#sudo snap install opera steam spotify