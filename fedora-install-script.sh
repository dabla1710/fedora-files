#!/bin/bash

sudo dnf update --assumeyes && sudo dnf upgrade --assumeyes

#  --- folder setup --- 
mkdir -p ~/.tmp
mkdir -p ~/development


# --- hostname to human tongue --- 
hostnamectl hostname --static fedora-workstation
hostnamectl hostname --pretty fedora-workstation


# --- Command Line Utilities ---
sudo dnf install --assumeyes fish helix kitty tmux alacritty fastfetch tree htop



# --- Neovim & LazyVim ---
sudo dnf install --assumeyes neovim

# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# Remove the `.git` folder, so you can add it to your own repo later
git clone https://github.com/LazyVim/starter ~/.config/nvim
# rm -rf ~/.config/nvim/.git
rm -rf ~/.config/nvim/.git



# --- Fonts ---
# Nerdfonts
sudo dnf copr enable --assumeyes che/nerd-fonts && sudo dnf install nerd-fonts

# --- Development Tools and Packages ---

sudo dnf groupinstall --assumeyes "Development Tools" "Development Libraries" # c, c++, zig, rust
sudo dnf install --assumeyes zig rustup go python3


# raylib
sudo dnf install --assumeyes raylib libX11devel
sudo dnf install --assumeyes clang-devel alsa-lib-devel mesa-libGL-devel libX11-devel libXrandr-devel libXi-devel libXcursor-devel libXinerama-devel wayland-devel libxkbcommon-devel libatomic cmake 

# --- Language Servers --- 

# bash
sudo dnf install --assumeyes nodejs-bash-language-server
# go
sudo dnf install -assumeyes golang-x-tools-gopls
# zigtools
sudo dnf copr enable --assumeyes sentry/zls 
sudo dnf install --assumeyes zls lldb-devel
# llvm
sudo dnf install --assumeeyes llvm

# --- gnome utilities ( add if statement or check for gnome desktop) --- 
sudo dnf install --assumeyes gnome-tweaks gnome-extensions-app gnome-keyring


# --- GUI Applications --- 
sudo dnf install --assumeyes thunderbird


#  --- steam servers --- 
# !Project Zomboid for fedora 40 in work

# --- flatpaks ---
flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub io.github.shiftey.Desktop
flatpak install -y flathub com.axosoft.GitKraken
flatpak install -y flathub com.valvesoftware.Steam
flatpak install -y flathub net.davidotek.pupgui2 # proton-up
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.onlyoffice.desktopeditors
flatpak install -y flathub com.brave.Browser
flatpak install -y flathub org.blender.Blender
flatpak install -y flathub org.gimp.GIMP
flatpak install -y flathub com.jetbrains.CLion
flatpak install -y flathub com.jetbrains.GoLand
flatpak install -y flathub com.mattjakeman.ExtensionManager
flatpak install -y flathub me.timschneeberger.jdsp4linux
flatpak install -y flathub com.usebottles.bottles # bottles for gamma emulation
flatpak install -y flathub me.proton.Mail
flatpak install -y flathub com.github.Matoking.protontricks
echo "--- Flatpaks installed ---"


#  --- automating github if possible with new key access?  --- 
### 


#  --- Post Install Setup  --- 
chsh -s /bin/fish "$USER"


echo "--- Setup done! ---"
