#!/usr/bin/env bash
set -e

### --- setup status/output split ---

# Save original stdout (main terminal) for status messages
exec 3>&1

# Create FIFO for noisy output
DOWNLOAD_FIFO="/tmp/install_downloads.$$"
mkfifo "$DOWNLOAD_FIFO"

# Cleanup on exit or error
cleanup() {
  rm -f "$DOWNLOAD_FIFO"
}
trap cleanup EXIT

# Open second terminal for downloads/logs
hyprctl dispatch exec "[float;size 900 600] foot bash -c 'echo Downloads / Logs; echo; cat \"$DOWNLOAD_FIFO\"'"

# Redirect all stdout + stderr to the downloads terminal
exec >"$DOWNLOAD_FIFO" 2>&1

# Status helper (prints to main terminal)
status() {
  echo "[*] $*" >&3
}

### --- script starts here ---

status "Starting install"

cd ~
status "Changed to home directory"

sudo -v
status "Sudo credentials cached"

bash redone/scripts/dependesies.sh
status "Done with dependencies"

bash redone/scripts/yay_installs.sh
status "Done with yay installs"

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  github-desktop >/dev/null 2>&1 &
  status "GitHub Desktop launched"
fi

mkdir -p ~/Documents
cd ~/Documents
status "Entered Documents directory"

git clone https://github.com/willbill0808/hyprland_setup.git
status "Hyprland setup repository cloned"

bash redone/scripts/hypr_set.sh
status "Hyprland configuration applied"

swww-daemon >/dev/null 2>&1 &
swww img ~/Documents/hyprland_setup/redone/wallpapers/wallpaper.jpg
status "Wallpaper applied"

status "INSTALL COMPLETE"
