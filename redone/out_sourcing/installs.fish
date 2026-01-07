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

github-desktop &

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

set_color yellow
read -P "Do you want to reboot(best for clean install)? (y/n) " answer
set_color normal

if string match -qi y $answer
    echo "User chose yes"
    reboot
else
    echo "User chose no"
end
