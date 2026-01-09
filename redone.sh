#!/usr/bin/env bash

#set -e

### --- ensure sudo can always prompt ---
exec < /dev/tty

### --- setup status/output split ---

# Save original stdout (main terminal) for status messages
exec 3>&1

# Pick a terminal (no foot dependency)
TERMINAL_CMD="${TERMINAL:-kitty}"

# FIFO for noisy output
DOWNLOAD_FIFO="/tmp/install_downloads.$$"
mkfifo "$DOWNLOAD_FIFO"

# Cleanup on exit or error
cleanup() {
  rm -f "$DOWNLOAD_FIFO"
}
trap cleanup EXIT

# Start a guaranteed FIFO reader FIRST (prevents blocking)
cat "$DOWNLOAD_FIFO" >/dev/null &
FIFO_FALLBACK_PID=$!

# Try to open a terminal for logs (non-fatal)
if command -v "$TERMINAL_CMD" >/dev/null 2>&1; then
  hyprctl dispatch exec \
    "[float;size 900 600] $TERMINAL_CMD -e bash -c 'echo Downloads / Logs; echo; cat \"$DOWNLOAD_FIFO\"'" \
    || true
fi

# Redirect all stdout + stderr to FIFO (non-fatal)
exec >"$DOWNLOAD_FIFO" 2>&1 || exec >/dev/null 2>&1

# Status helper (prints only to main terminal)
status() {
  echo "[*] $*" >&3
}

### --- script starts here ---

status "Starting install"

cd ~
status "Changed to home directory"

sudo true
status "Sudo credentials cached"

sudo pacman -Syu zsh base-devel git --noconfirm
status "Base packages installed"

mkdir -p ~/Documents
cd ~/Documents
status "Entered Documents directory"

https://github.com/willbill0808/hyprland_setup.git

status "Hyprland setup repository cloned"

cd hyprland_setup

bash redone/out_sourcing/scripts/dependesies.sh
status "Done with dependencies"

bash redone/scripts/yay_installs.sh
status "Done with yay installs"

bash redone/scripts/hypr_set.sh
status "Hyprland configuration applied"

swww-daemon >/dev/null 2>&1 &
swww img redone/wallpapers/wallpaper.jpg
status "Wallpaper applied"

status "INSTALL COMPLETE"


github-desktop 
status "GitHub Desktop launched"

