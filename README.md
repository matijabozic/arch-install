Use at your own risk! This script will reformat your HDD!<br />
Bash script that installs Arch Linux with Plasma Desktop!

Connect to Wireless network (Skip this step if you are using ethernet)
```
iwctl
station <device> connect <SSID>
<password>
CTRL + D
```
Install git, so you can git clone this repository
```
pacman -Sy git
```

Download script
```
git clone https://github.com/matijabozic/arch-install
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
Set username, password and root password during installation.<br/>
Restart when script is done installing, should get you into SSDM from where you can login into Plasma Desktop!
