#base stuff
sudo pacman -Syu unzip nautilus vscode rofi gnome-keyring base-devel git --noconfirm

#snap
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si

sudo systemctl enable --now snapd.socket

#snap stuff
sudo snap install opera steam spotify

#yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#yay stuff
yay -S github-desktop