cd ~

sudo sed -i '/#\[multilib\]/,/Include/s/^#//' /etc/pacman.conf

sudo pacman -Syu zsh fish base-devel git gnome-keyring hyprlock hypridle hyprpaper waybar spotify-launcher swww swaync unzip nautilus vscode rofi fastfetch btop  
sudo pacman -S steam 

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si
cd ..

yay -S nwg-look-bin librewolf-bin github-desktop 

github-desktop & disown

mkdir Documents 
cd Documents

git clone https://github.com/willbill0808/hyprland_setup.git

cd hyprland_setup/redone/out_sourcing

cp hyprland.conf $HOME/.config/hypr
cp hyprlock.conf $HOME/.config/hypr
cp hyprpaper.conf $HOME/.config/hypr

cp ~     

swww-daemon & disown

swww img Documents/hyprland_setup/redone/wallpapers/wallpaper.jpg
