#!/usr/bin/env bash

# Bash script that installs Arch Linux following ArchLinux Wiki Installation guide:
# https://wiki.archlinux.org/title/installation_guide
#
# GLOBAL VARIABLES USED THROUGH THE SCRIPT:
#
# Defined ./arch-install.conf:
# ARCH_DISK
# ARCH_BOOT_SIZE
# ARCH_SWAP_SIZE
# ARCH_HOSTNAME
# ARCH_TIMEZONE
# ARCH_LOCALE_GENERATE
# ARCH_LOCALE
# ARCH_VCONSOLE
# ARCH_PACKAGES
# ARCH_SERVICES

# Generated by the script before installation:
# ARCH_BOOT_PARTITION
# ARCH_SWAP_PARTITION
# ARCH_ROOT_PARTITION

# Asked during installation process:
# ARCH_USER
# ARCH_PASSWORD
# ARCH_PASSWORD_VERIFY
# ARCH_ROOT_PASSWORD
# ARCH_ROOT_PASSWORD_VERIFY
# ------------------------------------------------------------------------------

set -e          # Exit script if one of the commands fail
set -u          # Treat unset variables as an error, and immediately exit.
set -o pipefail # Exit on errors in pipeline

# ------------------------------------------------------------------------------
# Helper function that detects and 'returns' CPU microcode
# ------------------------------------------------------------------------------
get_microcode() {
    if lscpu | grep -q "GenuineIntel"; then
        echo "intel-ucode"
    elif lscpu | grep -q "AuthenticAMD"; then
        echo "amd-ucode"
    else
        exit 1
    fi
}

# ------------------------------------------------------------------------------
# Include variables defined in ./arch-install.conf
# ------------------------------------------------------------------------------
#shellcheck disable=SC1091
source ./arch-install.conf

# ------------------------------------------------------------------------------
# Generate variables not defined in ./arch-install.conf
# ------------------------------------------------------------------------------
[[ "$ARCH_DISK" = "/dev/nvm"* ]] && ARCH_BOOT_PARTITION="${ARCH_DISK}p1" || ARCH_BOOT_PARTITION="${ARCH_DISK}1"
[[ "$ARCH_DISK" = "/dev/nvm"* ]] && ARCH_SWAP_PARTITION="${ARCH_DISK}p2" || ARCH_SWAP_PARTITION="${ARCH_DISK}2"
[[ "$ARCH_DISK" = "/dev/nvm"* ]] && ARCH_ROOT_PARTITION="${ARCH_DISK}p3" || ARCH_ROOT_PARTITION="${ARCH_DISK}3"

# ------------------------------------------------------------------------------
# Ask for sensitive variables that can't be defined in ./arch-install.conf
# ------------------------------------------------------------------------------
get_user_data() {
    clear
    read -r -p 'Enter your username: ' ARCH_USER
    clear

    while true; do
        read -r -s -p 'User password: ' ARCH_PASSWORD
        echo
        read -r -s -p 'User password verify: ' ARCH_PASSWORD_VERIFY
        echo
        if [[ "$ARCH_PASSWORD" != "$ARCH_PASSWORD_VERIFY" ]]; then
            clear
            echo "Paswords don't match, try again:"
        else
            break
        fi
    done
    clear

    while true; do
        read -r -s -p 'Root password: ' ARCH_ROOT_PASSWORD
        echo
        read -r -s -p 'Root password verify: ' ARCH_ROOT_PASSWORD_VERIFY
        echo
        if [[ "$ARCH_ROOT_PASSWORD" != "$ARCH_ROOT_PASSWORD_VERIFY" ]]; then
            clear
            echo "Paswords don't match, try again:"
        else
            break
        fi
    done
    clear
}

# ------------------------------------------------------------------------------
# Unmount mounted partitions
# ------------------------------------------------------------------------------
partitions_unmount() {
    swapoff -a &>/dev/null || true
    umount -A -R /mnt &>/dev/null || true
}

# ------------------------------------------------------------------------------
# Partition hard drive
# ------------------------------------------------------------------------------
partitions_create() {
    parted -s "$ARCH_DISK" -- mklabel gpt \
        mkpart BOOT fat32 1MiB $((1 + "$ARCH_BOOT_SIZE"))MiB \
        mkpart SWAP linux-swap $((1 + "$ARCH_BOOT_SIZE"))MiB $((1 + "$ARCH_BOOT_SIZE" + "$ARCH_SWAP_SIZE"))MiB \
        mkpart ROOT ext4 $((1 + "$ARCH_BOOT_SIZE" + "$ARCH_SWAP_SIZE"))MiB 100% \
        set 1 boot on
}

# ------------------------------------------------------------------------------
# Format partitions
# ------------------------------------------------------------------------------
partitions_format() {
    mkfs.fat -F 32 -n BOOT "$ARCH_BOOT_PARTITION"
    mkswap -L SWAP "$ARCH_SWAP_PARTITION"
    mkfs.ext4 -F -L ROOT "$ARCH_ROOT_PARTITION"
}

# ------------------------------------------------------------------------------
# Mount partitions
# ------------------------------------------------------------------------------
partitions_mount() {
    mount "$ARCH_ROOT_PARTITION" /mnt
    mkdir /mnt/boot
    mount "$ARCH_BOOT_PARTITION" /mnt/boot
    swapon "$ARCH_SWAP_PARTITION"
}

# ------------------------------------------------------------------------------
# Install Arch linux
# ------------------------------------------------------------------------------
install_arch() {
    pacman-key --init
    pacman-key --populate
    pacman -Sy --noconfirm --disable-download-timeout archlinux-keyring
    pacstrap -K /mnt "${ARCH_PACKAGES[@]}" --disable-download-timeout
}

# ------------------------------------------------------------------------------
# Generate fstab file
# ------------------------------------------------------------------------------
generate_fstab() {
    genfstab -L /mnt >>/mnt/etc/fstab
}

# ------------------------------------------------------------------------------
# Set root password
# ------------------------------------------------------------------------------
set_root_password() {
    printf "%s\n%s" "${ARCH_ROOT_PASSWORD}" "${ARCH_ROOT_PASSWORD}" | arch-chroot /mnt passwd
}

# ------------------------------------------------------------------------------
# Add user
# ------------------------------------------------------------------------------
add_user() {
    arch-chroot /mnt useradd -m "$ARCH_USER"
    printf "%s\n%s" "${ARCH_PASSWORD}" "${ARCH_PASSWORD}" | arch-chroot /mnt passwd "$ARCH_USER"
}

# ------------------------------------------------------------------------------
# Add sudo user
# ------------------------------------------------------------------------------
add_sudo_user() {
    arch-chroot /mnt bash -c "echo '${ARCH_USER} ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo"
}

# ------------------------------------------------------------------------------
# Create hostname
# ------------------------------------------------------------------------------
set_hostname() {
    echo "$ARCH_HOSTNAME" >/mnt/etc/hostname
}

# ------------------------------------------------------------------------------
# Set hosts
# ------------------------------------------------------------------------------
set_hosts() {
    {
        echo '127.0.0.1    localhost'
        echo '::1          localhost'
    } >/mnt/etc/hosts
}

# ------------------------------------------------------------------------------
# Localization
# ------------------------------------------------------------------------------
set_localization() {
    # Uncomment locales defined in ARCH_LOCALE_GENERATE
    for value in "${ARCH_LOCALE_GENERATE[@]}"; do
        sed -i "s/#${value}/${value}/g" "/mnt/etc/locale.gen"
    done

    # Generate locales
    arch-chroot /mnt locale-gen

    # Write locales from ARCH_LOCALE into /mnt/etc/locale.conf
    for value in "${ARCH_LOCALE[@]}"; do
        echo "$value"
    done >/mnt/etc/locale.conf
}

# ------------------------------------------------------------------------------
# Keyboard layout
# ------------------------------------------------------------------------------
set_keyboard_layout() {
    for value in "${ARCH_VCONSOLE[@]}"; do
        echo "$value"
    done >/mnt/etc/vconsole.conf
}

# ------------------------------------------------------------------------------
# Time zone
# ------------------------------------------------------------------------------
set_timezone() {
    arch-chroot /mnt ln -sf "/usr/share/zoneinfo/$ARCH_TIMEZONE" /etc/localtime
    arch-chroot /mnt hwclock --systohc
}

# ------------------------------------------------------------------------------
# Install and configure boot loader
# ------------------------------------------------------------------------------
install_bootloader() {
    arch-chroot /mnt bootctl --esp-path=/boot install

    {
        echo "default arch.conf"
        # echo "timeout 5"
    } >/mnt/boot/loader/loader.conf

    {
        echo "title Arch Linux"
        echo "linux /vmlinuz-linux"
        echo "initrd /$(get_microcode).img"
        echo "initrd /initramfs-linux.img"
        echo "options root=UUID=$(blkid -o value -s UUID "$ARCH_ROOT_PARTITION") rw"
    } >/mnt/boot/loader/entries/arch.conf

    {
        echo "title Arch Linux (fallback)"
        echo "linux /vmlinuz-linux"
        echo "initrd /$(get_microcode).img"
        echo "initrd /initramfs-linux-fallback.img"
        echo "options root=UUID=$(blkid -o value -s UUID "$ARCH_ROOT_PARTITION") rw"
    } >/mnt/boot/loader/entries/arch-fallback.conf
}

# ------------------------------------------------------------------------------
# Enable services defined in ARCH_SERVICES
# ------------------------------------------------------------------------------
enable_services() {
    for service in "${ARCH_SERVICES[@]}"; do
        arch-chroot /mnt systemctl enable "$service"
    done
}

# ------------------------------------------------------------------------------
# Main scripts entry point
# ------------------------------------------------------------------------------
main() {
    get_user_data
    partitions_unmount
    partitions_create
    partitions_format
    partitions_mount
    install_arch
    generate_fstab
    set_root_password
    add_user
    add_sudo_user
    set_hostname
    set_hosts
    set_localization
    set_keyboard_layout
    set_timezone
    install_bootloader
    enable_services
}

main

# timedatectl set-ntp true
# timedatectl set-timezone "$ARCH_TIMEZONE"
# timedatectl status
