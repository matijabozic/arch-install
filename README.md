Collection of bash scripts that automate installation of Arch Linux! <br />
Heavily customized and experimental, use at your own risk!

Connect to Wireless network (Skip this step if you are using ethernet)
```
iwctl
station <device> connect <SSID>
<password>
CTRL + D
```
Install git
```
pacman -Sy git
```

Change DNS and restart network so DNS change takes effect
```
vim /etc/systemd/resolved.conf
systemctl restart systemd-resolved
```

Download script
```
git clone https://github.com/matijabozic/arch-install
```

Enter arch-install folder
```
cd arch-install
```

Edit config (add drive you want arch to install to)
```
vim arch-install.conf
```

Make script file executable
```
chmod +x arch-install.sh
```

Run script
```
./arch-install.sh
```

Restart, and then install one of desktop environments!

