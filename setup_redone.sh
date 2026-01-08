set -e

cd ~

echo 

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf

sudo pacman -Syu zsh steam fish base-devel git gnome-keyring \
  hyprlock hypridle hyprpaper waybar spotify-launcher swww swaync \
  unzip nautilus vscode rofi fastfetch btop discord flatpak prismlauncher --noconfirm

sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk  xdg-desktop-portal-hyprland --noconfirm


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

swww-daemon >/dev/null 2>&1 &
swww img ~/Documents/hyprland_setup/redone/wallpapers/wallpaper.jpg
