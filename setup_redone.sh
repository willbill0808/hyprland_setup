set -e

cd ~

sudo -v

sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
sudo pacman -Syu zsh steam fish cava base-devel git gnome-keyring hyprlock hypridle hyprpaper impala spotify-launcher swww swaync unzip nautilus vscode rofi fastfetch btop discord flatpak nwg-look otf-geist-mono-nerd impala --noconfirm
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk  xdg-desktop-portal-hyprland --noconfirm

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si --noconfirm
cd ..

yay -S brave-bin waybar-cava github-desktop --noconfirm

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  github-desktop >/dev/null 2>&1 &
fi

mkdir -p ~/Documents
cd ~/Documents

git clone https://github.com/willbill0808/hyprland_setup.git

cd hyprland_setup/redone/out_sourcing

mkdir -p ~/.config/hypr
cp hyprland.conf hyprlock.conf hyprpaper.conf ~/.config/hypr/

mkdir -p ~/.config/kitty
cp terminal/kitty.conf ~/.config/kitty/

cd ~

git clone https://github.com/adi1090x/rofi.git

cd rofi/files

mkdir -p ~/.config/rofi
cp -r colors config.rasi launchers ~/.config/rofi

cd ~/Documents/hyprland_setup/redone/out_sourcing
cp launcher.sh ~/.config/rofi/launchers/type-2
cp denji.rasi ~/.config/rofi/colors
cp -r shared ~/.config/rofi/launchers/type-2

cd ~

sudo pacman -S --needed \
  ttf-dejavu \
  ttf-liberation \
  noto-fonts \
  noto-fonts-emoji \
  ttf-opensans ttf-font-awesome

fc-cache -rv


swww-daemon >/dev/null 2>&1 &
swww img ~/Documents/hyprland_setup/redone/wallpapers/wallpaper.jpg

