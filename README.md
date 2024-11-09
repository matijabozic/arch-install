Bash script that installs Arch Linux with Plasma Desktop!x<br />
Use at your own risk! This script will reformat your HDD!

Connect to Wireless network (Skip this step if you are using ethernet)
```
iwctl
station <device> connect <SSID>
<password>
CTRL + D
```
Install git, so we can git clone this repository
```
pacman -Sy git
```

Download script
```
git clone https://github.com/matijabozic/arch-install
```

If you get errors while trying to ```git clone``` this repo, change DNS and restart network so DNS change takes effect
```
vim /etc/systemd/resolved.conf
systemctl restart systemd-resolved
```

Enter arch-install folder
```
cd arch-install
```

Edit config (add drive you want arch to install to, change locales, packages etc...)
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

Restart, should get you into SSDM from where you can login into Plasma Desktop!
