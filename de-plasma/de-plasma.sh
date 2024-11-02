#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Installs Plasma Desktop Environment
#-------------------------------------------------------------------------------

set -e          # Exit script if one of the commands fail
set -u          # Treat unset variables as an error, and immediately exit.
set -o pipefail # Exit on errors in pipeline

packages=()

#-------------------------------------------------------------------------------
# Plasma Desktop
#-------------------------------------------------------------------------------
packages+=("plasma-desktop")         # KDE Plasma Desktop
packages+=("plasma-nm")              # Plasma applet written in QML for managing network connections
packages+=("kscreen")                # KDE screen management software
packages+=("sddm")                   # QML based X11 and Wayland display manager
packages+=("sddm-kcm")               # KDE Config Module for SDDM
packages+=("konsole")                # KDE terminal emulator
packages+=("dolphin")                # KDE File Manager
packages+=("ark")                    # Archiving Tool
packages+=("noto-fonts")             # Google Noto TTF fonts

#-------------------------------------------------------------------------------
# Plasma Desktop Utilities
#-------------------------------------------------------------------------------
packages+=("neovim")               # Fork of Vim aiming to improve user experience, plugins, and GUIs
packages+=("man-db")               # A utility for reading man pages
packages+=("ntfs-3g")              # NTFS filesystem driver and utilities
packages+=("kcalc")                # Scientific Calculator
packages+=("okular")               # Document Viewer
packages+=("partitionmanager")     # A KDE utility that allows you to manage disks, partitions, and file systems
packages+=("plasma-systemmonitor") # An interface for monitoring system sensors, process information and other system resources

#packages+=("yakuake")              # A drop-down terminal emulator based on KDE konsole technology
#packages+=("elisa")                # A simple music player aiming to provide a nice experience for its us
#packages+=("gwenview")             # A fast and easy to use image viewer
#packages+=("kamoso")               # A webcam recorder from KDE community
#packages+=("kcharselect")          # Character Selector
#packages+=("kcolorchooser")        # Color Chooser
#packages+=("kolourpaint")          # Paint Program
#packages+=("ksystemlog")           # System log viewer tool
#packages+=("base-devel")           # Basic tools to build Arch Linux packages
#packages+=("cpupower")             # Linux kernel tool to examine and tune power saving related features of your processor
#packages+=("lm_sensors")           # Collection of user space tools for general SMBus access and hardware monitoring

#-------------------------------------------------------------------------------
# Audio
#-------------------------------------------------------------------------------
packages+=("pipewire")       # Low-latency audio/video router and processor
packages+=("pipewire-alsa")  # ALSA configuration
packages+=("pipewire-audio") # Audio support
packages+=("pipewire-jack")  # JACK support
packages+=("pipewire-pulse") # PulseAudio replacement
packages+=("plasma-pa")      # Plasma applet for audio volume management using PulseAudio
packages+=("wireplumber")    # Session / policy manager implementation

#-------------------------------------------------------------------------------
# Bluetooth
#-------------------------------------------------------------------------------
#packages+=("bluez")     # Daemons for the bluetooth protocol stack
#packages+=("bluedevil") # Integrate the Bluetooth technology within KDE workspace and applications

#-------------------------------------------------------------------------------
# Fonts
#-------------------------------------------------------------------------------
#packages+=("adobe-source-code-pro-fonts") # Monospaced font family for user interface and coding environments
#packages+=("otf-font-awesome")            # Iconic font designed for Bootstrap
#packages+=("ttf-cascadia-code")           # A monospaced font by Microsoft that includes programming ligatures
#packages+=("ttf-fira-code")               # Monospaced font with programming ligatures
#packages+=("ttf-jetbrains-mono")          # Typeface for developers, by JetBrains
#packages+=("ttf-liberation")              # Font family which aims at metric compatibility with Arial, Times New Roman, and Courier New
#packages+=("ttf-profont-nerd")            # Patched font ProFont from nerd fonts library
#packages+=("ttf-roboto")                  # Google's signature family of fonts
#packages+=("ttf-roboto-mono")             # A monospaced addition to the Roboto type family.
#packages+=("ttf-ubuntu-font-family")      # Ubuntu font family

#-------------------------------------------------------------------------------
# Applications
#-------------------------------------------------------------------------------
#packages+=("discord")           # All-in-one voice and text chat for gamers
#packages+=("firefox")           # Fast, Private & Safe Web Browser
#packages+=("keepassxc")         # Cross-platform community-driven port of Keepass password manager
#packages+=("libreoffice-fresh") # LibreOffice branch which contains new features and program enhancements
#packages+=("pinta")             # Drawing/editing program modeled after Paint.NET. It's goal is to provide a simplified alternative to GIMP for casual users
#packages+=("qbittorrent")       # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
#packages+=("spectacle")         # KDE screenshot capture utility
#packages+=("thunderbird")       # All-in-one voice and text chat for gamers
#packages+=("vlc")               # Multi-platform MPEG, VCD/DVD, and DivX player

#-------------------------------------------------------------------------------
# Flatpak
#-------------------------------------------------------------------------------
#packages+=("flatpak")              # Linux application sandboxing and distribution framework (formerly xdg-app)
#packages+=("flatpak-kcm")          # Flatpak Permissions Management KCM

#-------------------------------------------------------------------------------
# Install packages
#-------------------------------------------------------------------------------
pacman -Syu "${packages[@]}"

#-------------------------------------------------------------------------------
# Enable services
#-------------------------------------------------------------------------------
systemctl enable sddm.service
