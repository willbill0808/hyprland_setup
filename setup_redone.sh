set -e

cd ~

sudo -v

bash redone/scripts/dependesies.sh

echo "done with dependensies"

bash redone/scripts/yay_installs.sh

echo "done with yay"

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  github-desktop >/dev/null 2>&1 &
fi

mkdir -p ~/Documents
cd ~/Documents

git clone https://github.com/willbill0808/hyprland_setup.git

bash redone/scripts/hypr_set.sh

echo "done with hypr_set"

swww-daemon >/dev/null 2>&1 &
swww img ~/Documents/hyprland_setup/redone/wallpapers/wallpaper.jpg

echo "done"
