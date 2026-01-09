#!/usr/bin/env bash

set -e

### --- setup status/output split ---

# Save original stdout (main terminal) for status messages
exec 3>&1

# Pick a terminal (no foot dependency)
TERMINAL_CMD="${TERMINAL:-kitty}"

# Log file for noisy output
LOG_FILE="/tmp/install.log"
: > "$LOG_FILE"

# Cleanup on exit or error
cleanup() {
  rm -f "$LOG_FILE"
}
trap cleanup EXIT

# Open second terminal to follow logs (reader exists FIRST)
$TERMINAL_CMD -e bash -c "echo 'Downloads / Logs'; echo; tail -f '$LOG_FILE'" &
LOG_READER_PID=$!

# Redirect all stdout + stderr through tee
exec > >(tee -a "$LOG_FILE") 2>&1

# Status helper (prints only to main terminal)
status() {
  echo "[*] $*" >&3
}

### --- script starts here ---

status "Starting install"

cd ~
status "Changed to home directory"

sudo -v
status "Sudo credentials cached"

sudo pacman -Syu zsh base-devel git --noconfirm
status "Base packages installed"

mkdir -p ~/Documents
cd ~/Documents
status "Entered Documents directory"

if [[ ! -d hyprland_setup ]]; then
  if git clone https://github.com/willbill0808/hyprland_setup.git; then
    status "Hyprland setup repository cloned"
  else
    status "Clone failed, continuing"
  fi
else
  status "Hyprland setup repository already exists"
fi

cd hyprland_setup

bash redone/out_sourcing/scripts/dependesies.sh
status "Done with dependencies"

bash redone/scripts/yay_installs.sh
status "Done with yay installs"

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  github-desktop >/dev/null 2>&1 &
  status "GitHub Desktop launched"
fi

bash redone/scripts/hypr_set.sh
status "Hyprland configuration applied"

swww-daemon >/dev/null 2>&1 &
swww img redone/wallpapers/wallpaper.jpg
status "Wallpaper applied"

status "INSTALL COMPLETE"
