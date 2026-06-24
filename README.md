# 🏗️ Arch Linux auto-install script

> **One-command automated Arch Linux installation with KDE Plasma Desktop.**
> Just set the target disk, run the script, enter your passwords, and walk away.

---

## ⚠️ DANGER — READ BEFORE USING

**This script will PERMANENTLY ERASE ALL DATA on the target disk (`ARCH_DISK`).**
It creates a fresh GPT partition table, destroying every existing partition.
There is no confirmation beyond pressing Enter. **Back up your data first.**

---

## 📋 What You Need

| Requirement | Details |
|-------------|---------|
| 🖥️ Arch Linux bootable USB | Burn the ISO with Rufus, Ventoy, or `dd` |
| 🌐 Internet connection | Ethernet (auto-detected) or WiFi (needs manual setup) |
| 💽 Target disk | Any internal drive — SATA (`/dev/sda`), NVMe (`/dev/nvme0n1`), or VirtIO (`/dev/vda`) |

---

## 🚀 Installation Steps

### 1️⃣ Boot from the Arch ISO

Insert your USB, boot from it, and you'll land in a root shell (`root@archiso ~ #`).
This is a minimal live environment — no desktop, just a terminal.

### 2️⃣ Connect to WiFi (skip if using ethernet)

Ethernet works automatically. For WiFi, Arch uses `iwctl` (interactive wireless tool):

```bash
iwctl
```

Inside the `iwctl` prompt:

```
station <device> connect <SSID>
<password>
CTRL + D
```

> **What is `<device>`?** Run `iwctl device list` to see your wireless interface name (usually `wlan0` or `wlp2s0`).
>
> **Why iwctl?** The Arch ISO ships `iwd` (iNet Wireless Daemon) by default. `iwctl` is its interactive client — lightweight and already available, no extra setup needed.

Verify connectivity:

```bash
ping -c 3 archlinux.org
```

### 3️⃣ Install Git

```bash
pacman -Sy git
```

> **Why Git?** The script is hosted on GitHub. `git clone` is the simplest way to download it. The `-Sy` flag syncs the package database so the live ISO knows about the latest package versions, then installs Git.

### 4️⃣ Download the script

```bash
git clone https://github.com/matijabozic/arch-install
cd arch-install
```

### ⚠️ If `git clone` fails with connection errors

The Arch live ISO sometimes has DNS resolution issues. Fix by switching to Cloudflare's DNS:

```bash
vim /etc/systemd/resolved.conf
```

Change `#DNS=` to `DNS=1.1.1.1`, then restart:

```bash
systemctl restart systemd-resolved
```

Then try `git clone` again.

> **Why DNS fails?** The live ISO uses a default DNS resolver that may not work in your network environment. Cloudflare's `1.1.1.1` is a reliable public DNS that works everywhere.

### 5️⃣ Edit the configuration

```bash
vim arch-install.conf
```

**You MUST set at least one variable:**

| Variable | Example | What it does |
|----------|---------|--------------|
| `ARCH_DISK` | `/dev/sda` | **Target disk** — everything on it will be erased |

Other common settings to customize:

| Variable | Example | What it does |
|----------|---------|--------------|
| `ARCH_HOSTNAME` | `My-PC` | Your computer's network name |
| `ARCH_TIMEZONE` | `Europe/Zagreb` | Sets system clock and default time |
| `ARCH_BOOT_SIZE` | `512` | Size of the EFI system partition in MiB |
| `ARCH_SWAP_SIZE` | `16384` | Swap space in MiB (set to your RAM size for hibernation support) |

Locales, keyboard layout, services, and packages can also be tweaked — see the inline comments in the file.

### 6️⃣ Make the script executable

```bash
chmod +x arch-install.sh
```

> **Why `chmod +x`?** By default, downloaded files don't have execute permission for security. This flag tells Linux the file is safe to run as a program.

### 7️⃣ Run the installation

```bash
./arch-install.sh
```

The script will:
1. Ask for your **username, user password, and root password** (passwords are typed blind — no visible characters for security)
2. **Wipe and partition** the target disk
3. **Download and install** ~80+ packages (base system, KDE Plasma, audio, Bluetooth, Firefox, etc.)
4. **Configure everything** — users, sudo, hostname, locales, timezone, bootloader
5. Done! 🎉

> ⏱️ The whole process takes **5–15 minutes** depending on your internet speed.

### 8️⃣ Reboot

```bash
reboot
```

Remove the USB when prompted. The system will boot into **SDDM** (KDE's display manager). Log in with the username and password you provided during installation.

---

## 📦 Customizing the Installation

All customization is done in **`arch-install.conf`**.

### Adding or removing packages

The `ARCH_PACKAGES` array controls every package that gets installed. The file is organized into clear sections:

```bash
# Comment out packages you don't want by adding # at the start
# Uncomment packages you want by removing the #

ARCH_PACKAGES+=("firefox")           # Web browser
# ARCH_PACKAGES+=("libreoffice-fresh") # Office suite (commented out — inactive)
```

### Changing default applications

| Replace this | With | Example |
|--------------|------|---------|
| Konsole | Alacritty | `ARCH_PACKAGES+=("alacritty")` |
| Dolphin | Thunar | `ARCH_PACKAGES+=("thunar")` |
| Firefox | Chromium | `ARCH_PACKAGES+=("chromium")` |

### Adding a desktop environment alongside Plasma

Want GNOME too? Add these lines:

```bash
ARCH_PACKAGES+=("gnome")
ARCH_PACKAGES+=("gdm")
ARCH_SERVICES+=("gdm.service")
```

> ⚠️ If you want GDM instead of SDDM, remove or comment out `sddm.service` from `ARCH_SERVICES`.

### Config reference

| Variable | Purpose | Default |
|----------|---------|---------|
| `ARCH_DISK` | Target disk to install on (**required**) | `""` (empty — must be set!) |
| `ARCH_BOOT_SIZE` | EFI system partition size in MiB | `512` |
| `ARCH_SWAP_SIZE` | Swap partition size in MiB | `16384` (16 GiB) |
| `ARCH_HOSTNAME` | Computer's network name | `Arch-PC` |
| `ARCH_TIMEZONE` | System timezone (see `timedatectl list-timezones`) | `Europe/Zagreb` |
| `ARCH_LOCALE_GENERATE` | Locales to generate in `/etc/locale.gen` | `en_US.UTF-8`, `hr_HR.UTF-8` |
| `ARCH_LOCALE` | Active locale settings for `/etc/locale.conf` | en_US + hr_HR (Croatian formats) |
| `ARCH_VCONSOLE` | Console keyboard layout | `KEYMAP=us` |
| `ARCH_SERVICES` | Systemd services to enable at boot | `NetworkManager`, `sddm`, `bluetooth` |
| `ARCH_PACKAGES` | All packages to install | 30+ packages (base, Plasma, audio, Bluetooth, Firefox) |

---

## ❓ Troubleshooting

| Problem | Likely cause | Solution |
|---------|-------------|----------|
| `git clone` fails | DNS resolution issue in live ISO | Change DNS to `1.1.1.1` in `/etc/systemd/resolved.conf` and restart the service |
| `pacstrap` is slow | Mirror speed or network | Use a wired connection, or run `reflector` before the script to find fast mirrors |
| Boot hangs or "no bootable device" | Wrong `ARCH_DISK` or BIOS/Legacy mode | Verify the target disk is correct and your system is set to **UEFI boot** (not CSM/Legacy) |
| No WiFi in Plasma | NetworkManager needs activation | Run `nmtui` in a terminal or use the Plasma network widget in the system tray |
| No sound | PipeWire/WirePlumber not running | Run `wpctl status` to check, then `systemctl --user restart wireplumber` |
| Keyboard layout wrong in Plasma | Only console layout was set | Change it in **System Settings → Keyboard** (Plasma handles layouts independently of the console) |

---

## 💡 Tips

- **🛋️ For laptops**: Add `power-profiles-daemon` (already included), `tlp`, and `acpi_call` for better battery management. Uncomment `cpupower` and `lm_sensors` in the config.
- **🎮 For gaming**: Add `steam`, `wine`, `lutris`, `gamemode`, `mesa-utils`, `vulkan-intel` or `vulkan-radeon` to `ARCH_PACKAGES`.
- **💻 For development**: Add `base-devel`, `git`, `docker`, `buildah`, `nodejs`, `npm`, `python`, `python-pip`, `rust`, `go`, `jdk-openjdk` to `ARCH_PACKAGES`.
- **🧘 Sit back**: The script handles everything — no babysitting needed during install. Once you enter your passwords, walk away.

---

## 📚 Resources

- [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
- [Arch Wiki: systemd-boot](https://wiki.archlinux.org/title/Systemd-boot)
- [Arch Wiki: KDE Plasma](https://wiki.archlinux.org/title/KDE)
- [Arch Wiki: PipeWire](https://wiki.archlinux.org/title/PipeWire)
