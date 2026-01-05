#!/usr/bin/env fish

cd ~

### ---- sudo keepalive ----
sudo -v; or exit 1
while true
    sudo -n true
    sleep 60
end &
set sudo_keepalive $last_pid

### ---- multilib ----
if not grep -q '^\[multilib\]' /etc/pacman.conf
    echo "==> Enabling multilib repository..."
    sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
    sudo pacman -Sy
else
    echo "==> Multilib already enabled."
end

### ---- base packages ----
sudo pacman -Syu \
    unzip nautilus vscode rofi gnome-keyring base-devel git steam \
    --noconfirm --needed; or exit 1
set_color green; echo "done with pacman"; set_color normal

### ---- snapd (AUR) ----
if not command -v snap >/dev/null
    if not test -d ~/snapd
        git clone https://aur.archlinux.org/snapd.git
    end
    cd ~/snapd
    makepkg -si --noconfirm --needed; or exit 1
    cd ~
end

if not systemctl is-enabled snapd.socket >/dev/null 2>&1
    sudo systemctl enable --now snapd.socket
end

if not test -e /snap
    sudo ln -sf /var/lib/snapd/snap /snap
end

set_color green; echo "done with snapd"; set_color normal

### ---- yay (AUR helper) ----
if not command -v yay >/dev/null
    if not test -d ~/yay
        git clone https://aur.archlinux.org/yay.git
    end
    cd ~/yay
    makepkg -si --noconfirm --needed; or exit 1
    cd ~
end

set_color green; echo "done with yay install"; set_color normal

### ---- yay packages ----
yay -S github-desktop --noconfirm --needed
set_color green; echo "done with yay packages"; set_color normal

### ---- wait for snap ----
set_color yellow; echo "waiting for snap"; set_color normal
while not snap version >/dev/null 2>&1
    sleep 1
end
set_color green; echo "snap ready"; set_color normal

### ---- snap packages ----
sudo snap install opera spotify --yes
set_color green; echo "done with snap packages"; set_color normal

### ---- cleanup ----
kill $sudo_keepalive
