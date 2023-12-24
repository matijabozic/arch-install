#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Installs Sway Window Manager
#-------------------------------------------------------------------------------
set -e          # Exit script if one of the commands fail
set -u          # Treat unset variables as an error and immediately exit.
set -o pipefail # Exit on errors in pipeline

packages=()

#-------------------------------------------------------------------------------
# Sway
#-------------------------------------------------------------------------------
packages+=("sway")     # Tiling Wayland compositor and replacement for the i3 window manager
packages+=("swaybg")   # Wallpaper tool for Wayland compositors
packages+=("swaylock") # Screen locker for Wayland
packages+=("swayidle") # Idle management daemon for Wayland
packages+=("mako")     # Lightweight notification daemon for Wayland
packages+=("wofi")     # Launcher for wlroots-based wayland compositors
packages+=("waybar")   # Highly customizable Wayland bar for Sway and Wlroots based compositors
packages+=("foot")     # Fast, lightweight, and minimalistic Wayland terminal emulator
packages+=("neovim")   # Fork of Vim aiming to improve user experience, plugins, and GUIs

#-------------------------------------------------------------------------------
# Sway Utilities
#-------------------------------------------------------------------------------
packages+=("man-db") # A utility for reading man pages
#packages+=("grim")         # Screenshot utility for Wayland
#packages+=("slurp")        # Select a region in a Wayland compositor
#packages+=("wl-clipboard") # Command-line copy/paste utilities for Wayland

#-------------------------------------------------------------------------------
# Support
#-------------------------------------------------------------------------------
packages+=("base-devel")             # Basic tools to build Arch Linux packages
packages+=("brightnessctl")          # Lightweight brightness control tool
packages+=("cpupower")               # Linux kernel tool to examine and tune power saving related features of your processor
packages+=("glib2")                  # Low level core library (includes gsettings which you need)
packages+=("gnome-keyring")          # Stores passwords and encryption keys
packages+=("gtk3")                   # GObject-based multi-platform GUI toolkit
packages+=("lm_sensors")             # Collection of user space tools for general SMBus access and hardware monitoring
packages+=("network-manager-applet") # Applet for managing network connections
packages+=("nm-connection-editor")   # NetworkManager GUI connection editor and widgets
packages+=("polkit-gnome")           # Legacy polkit authentication agent for GNOME
packages+=("polkit")                 # Application development toolkit for controlling system-wide privileges
packages+=("upower")                 # Abstraction for enumerating power devices, listening to device events and querying history and statistics
packages+=("xdg-utils")              # Command line tools that assist applications with a variety of desktop integration tasks
packages+=("xorg-xhost")             # Server access control program for X (gparted requirement)
packages+=("xorg-xwayland")          # Run X clients under wayland

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
# Graphics Drivers
#-------------------------------------------------------------------------------
# AMD
# packages+=("xf86-video-amdgpu")
# packages+=("libva-mesa-driver")
# packages+=("lib32-libva-mesa-driver")
# packages+=("vulkan-radeon")
# packages+=("lib32-vulkan-radeon")
# packages+=("mesa-vdpau")
# packages+=("lib32-mesa-vdpau")

# Intel
# packages+=("vulkan-intel")
# packages+=("lib32-vulkan-intel")
# packages+=("libva-intel-driver")
# packages+=("intel-media-driver")

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
# Bluetooth
#-------------------------------------------------------------------------------
packages+=("bluez")   # Daemons for the bluetooth protocol stack
packages+=("blueman") # GTK+ Bluetooth Manager

#-------------------------------------------------------------------------------
# Fonts
#-------------------------------------------------------------------------------
#packages+=("font-manager")                # A simple font management application for GTK+ Desktop Environments
#packages+=("adobe-source-code-pro-fonts") # Monospaced font family for user interface and coding environments
#packages+=("noto-fonts")                  #	Google Noto TTF fonts
#packages+=("otf-font-awesome")            # Iconic font designed for Bootstrap
#packages+=("ttf-liberation")              # Font family which aims at metric compatibility with Arial, Times New Roman, and Courier New
#packages+=("ttf-cascadia-code")           # A monospaced font by Microsoft that includes programming ligatures
#packages+=("ttf-jetbrains-mono")          # Typeface for developers, by JetBrains
#packages+=("ttf-fira-code")              # Monospaced font with programming ligatures
#packages+=("ttf-roboto-mono")            # A monospaced addition to the Roboto type family.
#packages+=("ttf-roboto")                 # Google's signature family of fonts
#packages+=("ttf-ubuntu-font-family")     # Ubuntu font family
#packages+=("ttf-profont-nerd")           # Patched font ProFont from nerd fonts library

#-------------------------------------------------------------------------------
# Applications
#-------------------------------------------------------------------------------
#packages+=("discord")           # All-in-one voice and text chat for gamers
#packages+=("opera")             # A fast and secure web browser
#packages+=("steam")             # Valve's digital software delivery system
#packages+=("gparted")           #	A Partition Magic clone, frontend to GNU Parted
#packages+=("keepassxc")         # Cross-platform community-driven port of Keepass password manager
#packages+=("libreoffice-fresh") # LibreOffice branch which contains new features and program enhancements
#packages+=("pinta")             # Drawing/editing program modeled after Paint.NET. It's goal is to provide a simplified alternative to GIMP for casual users
#packages+=("qbittorrent")       # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
#packages+=("thunderbird")       # All-in-one voice and text chat for gamers
#packages+=("vlc")               # Multi-platform MPEG, VCD/DVD, and DivX player

#-------------------------------------------------------------------------------
# Development
#-------------------------------------------------------------------------------
#packages+=("deno")   # A secure runtime for JavaScript and TypeScript
#packages+=("git")    # The fast distributed version control system
#packages+=("nodejs") # Evented I/O for V8 javascript
#packages+=("npm")    # A package manager for javascript
#packages+=("python") # Next generation of the python high-level scripting language

#-------------------------------------------------------------------------------
# Install packages
#-------------------------------------------------------------------------------
pacman -S "${packages[@]}"

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
# Copy dotfiles into /home/$USER/.config/
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
