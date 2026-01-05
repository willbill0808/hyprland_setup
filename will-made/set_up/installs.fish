#!/usr/bin/env fish

cd ~

### ---- sudo keepalive ----
sudo -v; or exit 1
while true
    sudo -n true
    sleep 60
end &
set sudo_keepalive $last_pid

function cleanup --on-event fish_exit
    kill $sudo_keepalive 2>/dev/null
end

### ---- multilib ----
if not grep -q '^\[multilib\]' /etc/pacman.conf
    echo "Enabling multilib repository..."
    sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
    sudo pacman -Sy
else
    echo "Multilib already enabled."
end

### ---- base packages ----
sudo pacman -Syu \
    unzip nautilus code rofi gnome-keyring base-devel git steam \
    --noconfirm --needed; or exit 1
echo "Pacman packages installed"

### ---- snapd (AUR) ----
if not command -v snap >/dev/null
    if not test -d ~/snapd
        git clone https://aur.archlinux.org/snapd.git
    end
    cd ~/snapd
    makepkg -si --noconfirm --needed; or exit 1
    cd ~
end

sudo systemctl enable --now snapd.socket snapd.service

if not test -e /snap
    sudo ln -sf /var/lib/snapd/snap /snap
end

echo "snapd installed and started"

### ---- yay (AUR helper) ----
if not command -v yay >/dev/null
    if not test -d ~/yay
        git clone https://aur.archlinux.org/yay.git
    end
    cd ~/yay
    makepkg -si --noconfirm --needed; or exit 1
    cd ~
end

echo "yay installed"

### ---- yay packages ----
yay -S github-desktop --noconfirm --needed
echo "yay packages installed"

### ---- wait for snap (with timeout) ----
echo "Waiting for snapd to become ready (30s timeout)"
set waited 0
while not snap version >/dev/null 2>&1
    sleep 1
    set waited (math $waited + 1)
    if test $waited -ge 30
        echo "snapd failed to start"
        exit 1
    end
end

echo "snapd ready"

### ---- snap packages ----
sudo snap install opera spotify --yes
echo "snap packages installed"
