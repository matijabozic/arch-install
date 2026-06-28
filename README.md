# Arch Linux auto-install script

One-command automated Arch Linux installation with KDE Plasma Desktop.
Set the target disk, run the script, enter your passwords, and walk away.

---

## ⚠️ DANGER — READ BEFORE USING

**This script will PERMANENTLY ERASE ALL DATA on the target disk (`ARCH_DISK`).**
It creates a fresh GPT partition table, destroying every existing partition.
There is no confirmation beyond pressing Enter. **Back up your data first.**

---

## 📋 Requirements

| Requirement | Details |
|-------------|---------|
| 💿 Arch Linux bootable USB | Burn the ISO with Rufus, Ventoy, or `dd` |
| 🌐 Internet connection | Ethernet (auto-detected) or WiFi (needs manual setup via `iwctl`) |
| 💽 Target disk | SATA (`/dev/sda`), NVMe (`/dev/nvme0n1`), or VirtIO (`/dev/vda`) |

---

## 🚀 Installation

### 1️⃣ Boot from the Arch ISO

Boot from your USB drive. You will land in a root shell (`root@archiso ~ #`).

### 2️⃣ Connect to WiFi (skip if using ethernet)

Ethernet works automatically. For WiFi, use `iwctl`:

```bash
iwctl
```

Inside the `iwctl` prompt:

```
station <device> connect <SSID>
<password>
CTRL + D
```

Run `iwctl device list` to find your wireless interface name (usually `wlan0` or `wlp2s0`).

Verify connectivity:

```bash
ping -c 3 archlinux.org
```

### 3️⃣ Install Git

```bash
pacman -Sy git
```

### 4️⃣ Download the script

```bash
git clone https://github.com/matijabozic/arch-install
cd arch-install
```

> 💡 If `git clone` fails due to DNS issues, set `DNS=1.1.1.1` in `/etc/systemd/resolved.conf`, restart `systemd-resolved`, and try again.

### 5️⃣ Edit the configuration

```bash
vim arch-install.conf
```

**You must set at least one variable:**

| Variable | Example | Description |
|----------|---------|-------------|
| `ARCH_DISK` | `/dev/sda` | Target disk — everything on it will be erased |

Other common settings to customize:

| Variable | Example | Description |
|----------|---------|-------------|
| `ARCH_HOSTNAME` | `My-PC` | Computer's network name |
| `ARCH_TIMEZONE` | `Europe/Zagreb` | System timezone |
| `ARCH_BOOT_SIZE` | `512` | EFI system partition size in MiB |
| `ARCH_SWAP_SIZE` | `16384` | Swap space in MiB (set to RAM size for hibernation support) |

### 6️⃣ Make the script executable

```bash
chmod +x arch-install.sh
```

### 7️⃣ Run the installation

```bash
./arch-install.sh
```

The script will:
1. Prompt for **username, user password, and root password** (passwords are typed blind)
2. **Wipe and partition** the target disk
3. **Download and install** all packages (base system, KDE Plasma, audio, Bluetooth, Firefox, etc.)
4. **Configure** users, sudo, hostname, locales, timezone, bootloader
5. Done

The whole process takes 5–15 minutes depending on internet speed.

### 8️⃣ Reboot

```bash
reboot
```

Remove the USB when prompted. The system will boot into SDDM (KDE's display manager).
Log in with the username and password you provided during installation.

---

## ⚙️ Customizing the Installation

All customization is done in **`arch-install.conf`**.

### Adding or removing packages

The `ARCH_PACKAGES` array controls every package. Comment or uncomment entries as needed:

```bash
ARCH_PACKAGES+=("firefox")             # Web browser
# ARCH_PACKAGES+=("libreoffice-fresh") # Office suite (commented out)
```

### Adding a desktop environment alongside Plasma

```bash
ARCH_PACKAGES+=("gnome")
ARCH_PACKAGES+=("gdm")
ARCH_SERVICES+=("gdm.service")
```

If you want GDM instead of SDDM, remove `sddm.service` from `ARCH_SERVICES`.

### 📋 Config reference

| Variable | Purpose | Default |
|----------|---------|---------|
| `ARCH_DISK` | Target disk (**required**) | `""` (must be set) |
| `ARCH_BOOT_SIZE` | EFI system partition size in MiB | `512` |
| `ARCH_SWAP_SIZE` | Swap partition size in MiB | `16384` (16 GiB) |
| `ARCH_HOSTNAME` | Computer's network name | `Arch-PC` |
| `ARCH_TIMEZONE` | System timezone | `Europe/Zagreb` |
| `ARCH_LOCALE_GENERATE` | Locales to generate in `/etc/locale.gen` | `en_US.UTF-8`, `hr_HR.UTF-8` |
| `ARCH_LOCALE` | Active locale settings for `/etc/locale.conf` | en_US + hr_HR |
| `ARCH_VCONSOLE` | Console keyboard layout | `KEYMAP=us` |
| `ARCH_SERVICES` | Systemd services to enable at boot | `NetworkManager`, `sddm`, `bluetooth` |
| `ARCH_PACKAGES` | All packages to install | Base + KDE Plasma + audio + Bluetooth + Firefox |

---

## 🔍 Troubleshooting

| Problem | Likely cause | Solution |
|---------|-------------|----------|
| 🌐 `git clone` fails | DNS resolution issue in live ISO | Set `DNS=1.1.1.1` in `/etc/systemd/resolved.conf`, restart service |
| 🐢 `pacstrap` is slow | Mirror speed or network | Use wired connection, or run `reflector` before the script |
| 🚫 Boot hangs or "no bootable device" | Wrong `ARCH_DISK` or BIOS/Legacy mode | Verify target disk and set system to **UEFI boot** (not CSM/Legacy) |
| 📶 No WiFi in Plasma | NetworkManager needs activation | Run `nmtui` or use the Plasma network widget |
| 🔇 No sound | PipeWire/WirePlumber not running | Run `wpctl status` to check, then `systemctl --user restart wireplumber` |
| ⌨️ Keyboard layout wrong in Plasma | Only console layout was set | Change in **System Settings > Keyboard** |

---

## 💡 Tips

- **💻 Laptops**: Add `tlp` and `acpi_call` for better battery management. Uncomment `cpupower` and `lm_sensors` in the config.
- **🎮 Gaming**: Add `steam`, `wine`, `lutris`, `gamemode`, and appropriate Vulkan drivers.
- **🔧 Development**: Add `base-devel`, `git`, `docker`, `nodejs`, `npm`, `python`, `python-pip`, `rust`, `go`, `jdk-openjdk`.

---

## 📚 Resources

- [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
- [Arch Wiki: systemd-boot](https://wiki.archlinux.org/title/Systemd-boot)
- [Arch Wiki: KDE Plasma](https://wiki.archlinux.org/title/KDE)
- [Arch Wiki: PipeWire](https://wiki.archlinux.org/title/PipeWire)
