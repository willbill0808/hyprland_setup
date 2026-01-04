#!/usr/bin/env fish

# Function to check if a package is installed via pacman
function is_installed_pacman
    pacman -Q $argv >/dev/null 2>&1
end

# Function to check if a package is installed via snap
function is_installed_snap
    snap list $argv >/dev/null 2>&1
end

# Update package database and system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install yay (AUR helper) if not installed
if not is_installed_pacman yay
    echo "Installing yay..."
    sudo pacman -S yay --noconfirm
else
    echo "yay is already installed. Updating yay..."
    yay -Syu yay --noconfirm
end

# Install Visual Studio Code (vscode) via pacman if not installed
if not is_installed_pacman  vscode 
    echo "Installing Visual Studio Code via pacman..."
    sudo pacman -S vscode --noconfirm
else
    echo "Visual Studio Code is already installed. Updating Visual Studio Code..."
    sudo pacman -Syu  vscode  --noconfirm
end

# Install GitHub Desktop via yay if not installed
if not is_installed_pacman github-desktop-bin
    echo "Installing GitHub Desktop..."
    yay -S github-desktop-bin --noconfirm
else
    echo "GitHub Desktop is already installed. Updating GitHub Desktop..."
    yay -Syu github-desktop-bin --noconfirm
end

# Install GNOME Keyring via pacman if not installed
if not is_installed_pacman gnome-keyring
    echo "Installing GNOME Keyring via pacman..."
    sudo pacman -S gnome-keyring --noconfirm
else
    echo "GNOME Keyring is already installed. Updating GNOME Keyring..."
    sudo pacman -Syu gnome-keyring --noconfirm
end

# Install Snap package manager if not installed
if not is_installed_pacman snapd
    echo "Installing Snap..."
    sudo pacman -S snapd --noconfirm
else
    echo "Snap is already installed."
end

# Enable and start snapd service if it's not enabled
# Use variable assignment for the systemctl check in Fish
set snapd_enabled (systemctl is-enabled snapd.socket 2>/dev/null)

if test "$snapd_enabled" != "enabled"
    echo "Enabling and starting snapd service..."
    sudo systemctl enable --now snapd.socket
else
    echo "Snapd service is already running."
end

# Install Steam via Snap if not installed
if not is_installed_snap steam
    echo "Installing Steam via Snap..."
    sudo snap install steam
else
    echo "Steam is already installed. Updating Steam..."
    sudo snap refresh steam
end

# Install Spotify via Snap if not installed
if not is_installed_snap spotify
    echo "Installing Spotify via Snap..."
    sudo snap install spotify
else
    echo "Spotify is already installed. Updating Spotify..."
    sudo snap refresh spotify
end

# Install Opera via Snap if not installed
if not is_installed_snap opera
    echo "Installing Opera Browser via Snap..."
    sudo snap install opera
else
    echo "Opera Browser is already installed. Updating Opera..."
    sudo snap refresh opera
end

# Final message
echo "yay, GitHub Desktop, GNOME Keyring, Snap, Visual Studio Code, Steam, Spotify, and Opera have been installed or updated successfully!"
