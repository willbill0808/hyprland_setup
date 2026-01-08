set -e

cd ~

sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf

sudo pacman -Syu zsh steam fish base-devel git gnome-keyring \
  hyprlock hypridle hyprpaper waybar spotify-launcher swww swaync \
  unzip nautilus vscode rofi fastfetch btop  

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  eval "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)" >/dev/null 2>&1 &
  export SSH_AUTH_SOCK
fi

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si --noconfirm
cd ..

yay -S nwg-look-bin librewolf-bin github-desktop --noconfirm

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  github-desktop >/dev/null 2>&1 &
fi

mkdir -p ~/Documents
cd ~/Documents

git clone https://github.com/willbill0808/hyprland_setup.git

cd hyprland_setup/redone/out_sourcing

mkdir -p ~/.config/hypr
cp hyprland.conf hyprlock.conf hyprpaper.conf ~/.config/hypr/

cd ~

systemctl --user enable gnome-keyring-daemon.service
systemctl --user enable gnome-keyring-daemon.socket
systemctl --user enable gnome-keyring-daemon-ssh.socket

swww-daemon >/dev/null 2>&1 &
swww img ~/Documents/hyprland_setup/redone/wallpapers/wallpaper.jpg
