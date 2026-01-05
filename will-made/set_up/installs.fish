#!/usr/bin/env fish

cd ~

if not grep -q '^\[multilib\]' /etc/pacman.conf
    echo "==> Enabling multilib repository..."
    sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
else
    echo "==> Multilib already enabled."
end

# Base packages
sudo pacman -Syu unzip nautilus vscode rofi gnome-keyring base-devel git steam --noconfirm; or exit 1
set_color green; echo "done with pacman"; set_color normal

# Snap
if not test -d ~/snapd
    git clone https://aur.archlinux.org/snapd.git
end
cd snapd
makepkg -si; or exit 1
sudo systemctl enable --now snapd.socket
sudo ln -sf /var/lib/snapd/snap /snap
cd ..
set_color green; echo "done with snap download"; set_color normal

# Yay
if not test -d ~/yay
    git clone https://aur.archlinux.org/yay.git
end
cd yay
makepkg -si; or exit 1
cd ..
set_color green; echo "done with yay download"; set_color normal

# Yay packages
yay -S github-desktop --noconfirm
set_color green; echo "done with yay"; set_color normal

set_color yellow; echo "waiting for snap sockets"; set_color normal
while not snap version >/dev/null 2>&1
    sleep 1
end
set_color green; echo "snap ready"; set_color normal

# Snap packages
sudo snap install opera spotify
set_color green; echo "done with snap"; set_color normal
