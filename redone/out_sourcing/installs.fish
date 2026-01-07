#!/usr/bin/env fish

cd ~

if not grep -q '^\[multilib\]' /etc/pacman.conf
    echo "==> Enabling multilib repository..."
    sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
else
    echo "==> Multilib already enabled."
end

# Base packages
sudo pacman -Syu swww  zsh swaync unzip nautilus vscode rofi gnome-keyring base-devel git steam fastfetch btop --noconfirm; or exit 1
set_color green; echo "done with pacman"; set_color normal

# Yay
if not test -d ~/yay
    git clone https://aur.archlinux.org/yay.git
end
cd yay
makepkg -si; or exit 1
cd ..
set_color green; echo "done with yay download"; set_color normal

# Yay packages
yay -S nwg-look-bin librewolf-bin github-desktop --noconfirm
set_color green; echo "done with yay"; set_color normal

github-desktop & disown

