#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Installs Hyprland Window Manager
#-------------------------------------------------------------------------------
set -e          # Exit script if one of the commands fail
set -u          # Treat unset variables as an error, and immediately exit.
set -o pipefail # Exit on errors in pipeline

packages=()
packages_aur=()

#-------------------------------------------------------------------------------
# Install AUR Helper - paru
#-------------------------------------------------------------------------------
temp="/home/matija/temp"
paru="https://aur.archlinux.org/paru-bin.git"

runuser -u matija -- mkdir "$temp"
runuser -u matija -- git clone "$paru" "$temp"
runuser -u matija -- bash -c "cd $temp"
runuser -u matija -- makepkg -si --noconfirm
runuser -u matija -- rm -rf "$temp"

#-------------------------------------------------------------------------------
# Hyprland
#-------------------------------------------------------------------------------
packages_aur+=("hyprland-git")        # A dynamic tiling Wayland compositor based on wlroots that doesn't sacrifice on its looks.
packages_aur+=("waybar-hyprland-git") # Highly customizable Wayland bar for Sway and Wlroots based compositors, with workspaces support for Hyprland (git version)
packages+=("mako")                    # Lightweight notification daemon for Wayland
packages_aur+=("tofi")                    # Launcher for wlroots-based wayland compositors
packages+=("foot")                    # Fast, lightweight, and minimalistic Wayland terminal emulator
packages+=("neovim")                  # Fork of Vim aiming to improve user experience, plugins, and GUIs

# polkit-kde-agent
# qt5-wayland
# qt5-wayland

#-------------------------------------------------------------------------------
# Support
#-------------------------------------------------------------------------------
packages+=("base-devel")             # Basic tools to build Arch Linux packages
packages+=("brightnessctl")          # Lightweight brightness control tool
packages+=("cpupower")               # Linux kernel tool to examine and tune power saving related features of your processor
packages+=("glib2")                  # Low level core library (includes gsettings which you need)
packages+=("gnome-keyring")          # Stores passwords and encryption keys
packages+=("mesa")                   # An open-source implementation of the OpenGL specification
packages+=("network-manager-applet") # Applet for managing network connections
packages+=("nm-connection-editor")   # NetworkManager GUI connection editor and widgets
packages+=("polkit-gnome")           # Legacy polkit authentication agent for GNOME
packages+=("polkit")                 # Application development toolkit for controlling system-wide privileges
packages+=("upower")                 # Abstraction for enumerating power devices, listening to device events and querying history and statistics
packages+=("vulkan-radeon")          # Radeon's Vulkan mesa driver
packages+=("xdg-utils")              # Command line tools that assist applications with a variety of desktop integration tasks
packages+=("xorg-xhost")             # Server access control program for X (gparted requirement)
packages+=("xorg-xwayland")          # Run X clients under wayland

# packages+=("lm_sensors")           # Collection of user space tools for general SMBus access and hardware monitoring
# packages+=("lib32-vulkan-radeon")  # Radeon's Vulkan mesa driver (32-bit)

#-------------------------------------------------------------------------------
# File Manager
#-------------------------------------------------------------------------------
packages+=("pcmanfm-gtk3") # Extremely fast and lightweight file manager (GTK+ 3 version)
packages+=("gvfs")         # Virtual filesystem implementation for GIO
packages+=("gvfs-mtp")     # Virtual filesystem implementation for GIO (MTP backend; Android, media player)
packages+=("file-roller")  # Create and modify archives
packages+=("p7zip")        # Command-line file archiver with high compression ratio
packages+=("ntfs-3g")      # NTFS filesystem driver and utilities

#-------------------------------------------------------------------------------
# Audio - https://wiki.archlinux.org/title/PipeWire
#-------------------------------------------------------------------------------
packages+=("pipewire")       # Low-latency audio/video router and processor
packages+=("wireplumber")    # Session / policy manager implementation for PipeWire
packages+=("pipewire-alsa")  # Low-latency audio/video router and processor - ALSA configuration
packages+=("pipewire-audio") # Low-latency audio/video router and processor - Audio support
packages+=("pipewire-jack")  # Low-latency audio/video router and processor - JACK support
packages+=("pipewire-pulse") # Low-latency audio/video router and processor - PulseAudio replacement
packages+=("pavucontrol")    # PulseAudio Volume Control

#-------------------------------------------------------------------------------
# Bluetooth
#-------------------------------------------------------------------------------
packages+=("bluez")   # Daemons for the bluetooth protocol stack
packages+=("blueman") # GTK+ Bluetooth Manager
# packages+=("blueberry") # Bluetooth configuration tool

#-------------------------------------------------------------------------------
# Fonts
#-------------------------------------------------------------------------------
packages+=("font-manager")                # A simple font management application for GTK+ Desktop Environments
packages+=("adobe-source-code-pro-fonts") # Monospaced font family for user interface and coding environments
packages+=("noto-fonts")                  #	Google Noto TTF fonts
packages+=("otf-font-awesome")            # Iconic font designed for Bootstrap
packages+=("ttf-cascadia-code")           # A monospaced font by Microsoft that includes programming ligatures
packages+=("ttf-fira-code")               # Monospaced font with programming ligatures
packages+=("ttf-jetbrains-mono")          # Typeface for developers, by JetBrains
packages+=("ttf-liberation")              # Font family which aims at metric compatibility with Arial, Times New Roman, and Courier New
packages+=("ttf-roboto-mono")             # A monospaced addition to the Roboto type family.
packages+=("ttf-roboto")                  # Google's signature family of fonts
packages+=("ttf-ubuntu-font-family")      # Ubuntu font family
# packages+=("ttf-profont-nerd")     # Patched font ProFont from nerd fonts library

#-------------------------------------------------------------------------------
# Applications
#-------------------------------------------------------------------------------
packages+=("libreoffice-fresh") # LibreOffice branch which contains new features and program enhancements
packages+=("opera")             # A fast and secure web browser
packages+=("keepassxc")         # Cross-platform community-driven port of Keepass password manager
packages+=("discord")           # All-in-one voice and text chat for gamers
packages+=("gparted")           #	A Partition Magic clone, frontend to GNU Parted

#-------------------------------------------------------------------------------
# Development
#-------------------------------------------------------------------------------
packages+=("deno")   # A secure runtime for JavaScript and TypeScript
packages+=("git")    # The fast distributed version control system
packages+=("man-db") # A utility for reading man pages
packages+=("nodejs") # Evented I/O for V8 javascript
packages+=("npm")    # A package manager for javascript
packages+=("python") # Next generation of the python high-level scripting language

#-------------------------------------------------------------------------------
# AUR packages
#-------------------------------------------------------------------------------
packages_aur+=("visual-studio-code-bin")
packages_aur+=("google-chrome")
packages_aur+=("cpupower-gui")

#-------------------------------------------------------------------------------
# Flatpak - wait for improvements then check again (themeing, outdated packages etc...)
#-------------------------------------------------------------------------------
# packages+=("flatpak")
# packages+=("xdg-desktop-portal")     # Desktop integration portals for sandboxed apps
# packages+=("xdg-desktop-portal-wlr") # xdg-desktop-portal backend for wlroots

# com.google.Chrome
# com.visualstudio.code
# com.xnview.XnViewMP
# nz.mega.MEGAsync
# org.freefilesync.FreeFileSync
# org.libreoffice.LibreOffice
# org.videolan.VLC

#-------------------------------------------------------------------------------
# Install packages
#-------------------------------------------------------------------------------
pacman -Syu "${packages[@]}"

#-------------------------------------------------------------------------------
# Install AUR packages
#-------------------------------------------------------------------------------
# paru -S "${packagesAUR[@]}"

#-------------------------------------------------------------------------------
# Add more pacman repositories
#-------------------------------------------------------------------------------
# /etc/pacman.conf

#-------------------------------------------------------------------------------
# Copy dotfiles into /home/$USER/.config/
#-------------------------------------------------------------------------------
