#!/bin/bash
# preparation
mkdir -p ~/.tmp
mkdir -p ~/development


# change hostname to human tongue
hostnamectl hostname --static fedora-workstation
hostnamectl hostname --pretty fedora-workstation

# --- Command Line Utilities ---
sudo dnf install fish helix kitty tmux alacritty neofetch tree htop

# Development Tools and Packages
sudo dnf groupinstall "Development Tools" "Development Libraries"
sudo dnf install zig rustup go python3

sudo dnf install raylib

echo "--- Development Tools and Packages installed ---"
# Language Servers (later)


# gnome utilities ( add if statement or check for gnome desktop)
sudo dnf install gnome-tweaks gnome-extensions-app gnome-keyring

# GUI Applications
sudo dnf install thunderbird

# --- flatpaks ---
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub io.github.shiftey.Desktop
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub net.davidotek.pupgui2 # proton-up
flatpak install flathub com.spotify.Client
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.onlyoffice.desktopeditors
flatpak install flathub com.brave.Browser
flatpak install flathub org.blender.Blender
flatpak install flathub org.gimp.GIMP
flatpak install flathub com.jetbrains.CLion
flatpak install flathub com.jetbrains.GoLand
flatpak install flathub com.mattjakeman.ExtensionManager

echo "--- Flatpaks installed ---"


# automating github if possible with new key access?
### 

# Post Install Setup
chsh -s /bin/fish $USER



echo "--- Setup done! ---"
