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
packages+=("plasma-wayland-session") # Plasma Wayland session
packages+=("plasma-nm")              # Plasma applet written in QML for managing network connections
packages+=("kscreen")                # KDE screen management software
packages+=("sddm")                   # QML based X11 and Wayland display manager
packages+=("sddm-kcm")               # KDE Config Module for SDDM
packages+=("konsole")                # KDE terminal emulator
packages+=("dolphin")                # KDE File Manager
packages+=("ark")                    # Archiving Tool

#-------------------------------------------------------------------------------
# Plasma Desktop Utilities
#-------------------------------------------------------------------------------
#packages+=("yakuake")             # A drop-down terminal emulator based on KDE konsole technology
packages+=("elisa")                # A simple music player aiming to provide a nice experience for its us
packages+=("gwenview")             # A fast and easy to use image viewer
packages+=("kamoso")               # A webcam recorder from KDE community
packages+=("kcalc")                # Scientific Calculator
packages+=("kcharselect")          # Character Selector
packages+=("kcolorchooser")        # Color Chooser
packages+=("kolourpaint")          # Paint Program
packages+=("ksystemlog")           # System log viewer tool
packages+=("okular")               # Document Viewer
packages+=("partitionmanager")     # A KDE utility that allows you to manage disks, partitions, and file systems
packages+=("plasma-systemmonitor") # An interface for monitoring system sensors, process information and other system resources

#-------------------------------------------------------------------------------
# Support
#-------------------------------------------------------------------------------
packages+=("base-devel") # Basic tools to build Arch Linux packages
packages+=("cpupower")   # Linux kernel tool to examine and tune power saving related features of your processor
packages+=("lm_sensors") # Collection of user space tools for general SMBus access and hardware monitoring
packages+=("man-db")     # A utility for reading man pages
packages+=("ntfs-3g")    # NTFS filesystem driver and utilities

#-------------------------------------------------------------------------------
# Graphics Drivers
#-------------------------------------------------------------------------------
packages+=("vulkan-radeon")       #	Radeon's Vulkan mesa driver
packages+=("lib32-vulkan-radeon") #	Radeon's Vulkan mesa driver (32-bit)

#-------------------------------------------------------------------------------
# Audio
#-------------------------------------------------------------------------------
packages+=("pipewire")       # Low-latency audio/video router and processor
packages+=("wireplumber")    # Session / policy manager implementation
packages+=("pipewire-alsa")  # ALSA configuration
packages+=("pipewire-audio") # Audio support
packages+=("pipewire-jack")  # JACK support
packages+=("pipewire-pulse") # PulseAudio replacement
packages+=("plasma-pa")      # Plasma applet for audio volume management using PulseAudio

#-------------------------------------------------------------------------------
# Fonts
#-------------------------------------------------------------------------------
packages+=("adobe-source-code-pro-fonts") # Monospaced font family for user interface and coding environments
#packages+=("noto-fonts")                  # Google Noto TTF fonts
#packages+=("otf-font-awesome")            # Iconic font designed for Bootstrap
#packages+=("ttf-cascadia-code")           # A monospaced font by Microsoft that includes programming ligatures
#packages+=("ttf-fira-code")               # Monospaced font with programming ligatures
#packages+=("ttf-jetbrains-mono")          # Typeface for developers, by JetBrains
#packages+=("ttf-liberation")              # Font family which aims at metric compatibility with Arial, Times New Roman, and Courier New
#packages+=("ttf-roboto-mono")             # A monospaced addition to the Roboto type family.
#packages+=("ttf-roboto")                  # Google's signature family of fonts
#packages+=("ttf-ubuntu-font-family")      # Ubuntu font family
#packages+=("ttf-profont-nerd")     # Patched font ProFont from nerd fonts library

#-------------------------------------------------------------------------------
# Flatpak
#-------------------------------------------------------------------------------
# packages+=("flatpak")
# packages+=("xdg-desktop-portal")     # Desktop integration portals for sandboxed apps
# packages+=("xdg-desktop-portal-kde") # xdg-desktop-portal backend for wlroots
# packages+=("discover")       # KDE and Plasma resources management GUI

# com.google.Chrome
# com.visualstudio.code
# com.xnview.XnViewMP
# nz.mega.MEGAsync
# org.freefilesync.FreeFileSync
# org.libreoffice.LibreOffice
# org.videolan.VLC

#-------------------------------------------------------------------------------
# Bluetooth
#-------------------------------------------------------------------------------
packages+=("bluez") # Daemons for the bluetooth protocol stack
#packages+=("blueman") # GTK+ Bluetooth Manager
#packages+=("blueberry") # Bluetooth configuration tool

#-------------------------------------------------------------------------------
# Development
#-------------------------------------------------------------------------------
packages+=("deno")   # A secure runtime for JavaScript and TypeScript
packages+=("git")    # The fast distributed version control system
packages+=("nodejs") # Evented I/O for V8 javascript
packages+=("npm")    # A package manager for javascript
packages+=("python") # Next generation of the python high-level scripting language

#-------------------------------------------------------------------------------
# Applications
#-------------------------------------------------------------------------------
packages+=("discord")           # All-in-one voice and text chat for gamers
packages+=("keepassxc")         # Cross-platform community-driven port of Keepass password manager
packages+=("libreoffice-fresh") # LibreOffice branch which contains new features and program enhancements
packages+=("opera")             # A fast and secure web browser
packages+=("pinta")             # Drawing/editing program modeled after Paint.NET. It's goal is to provide a simplified alternative to GIMP for casual users
packages+=("qbittorrent")       # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
packages+=("thunderbird")       # All-in-one voice and text chat for gamers
packages+=("vlc")               # Multi-platform MPEG, VCD/DVD, and DivX player
packages+=("spectacle")         # KDE screenshot capture utility
#packages+=("steam")            # Valve's digital software delivery system

#-------------------------------------------------------------------------------
# Install AUR helper - Paru
#-------------------------------------------------------------------------------
# temp_dir="${HOME}/temp/"
# aur_package="https://aur.archlinux.org/paru-bin.git"
# git clone "$aur_package" "$temp_dir"
# cd "$temp_dir" && makepkg -si --noconfirm
# rm -rf "$temp_dir"

# packagesAUR=()

# packagesAUR=("google-chrome")          # The popular and trusted web browser by Google (Stable Channel)
# packagesAUR=("visual-studio-code-bin") # Visual Studio Code (vscode): Editor for building and debugging modern web and cloud applications (official binary version)
# packagesAUR=("megasync-bin")           # Easy automated syncing between your computers and your MEGA cloud drive
# packagesAUR=("freefilesync-bin")       # Folder comparison and synchronization
# packagesAUR=("xnviewmp")               # An efficient multimedia viewer, browser and converter.

# paru -S "${packagesAUR[@]}"

#-------------------------------------------------------------------------------
# AUR Packages
#-------------------------------------------------------------------------------
# https://aur.archlinux.org/yay-bin.git
# https://aur.archlinux.org/visual-studio-code-bin.git
# https://aur.archlinux.org/google-chrome.git
# https://aur.archlinux.org/freefilesync-bin.git

#-------------------------------------------------------------------------------
# Install packages
#-------------------------------------------------------------------------------
pacman -Syu "${packages[@]}"
