Collection of bash scripts that automate installation of Arch Linux! <br />
Heavily customized and experimental, use at your own risk!

Connect to Wireless network
iwctl
station <device> connect <SSID>
<password>
CTRL + D

Install git
pacman -Sy git

Download script
git clone https://github.com/matijabozic/arch-install

Enter arch-install folder
cd arch-install

Edit config (add drive you want arch to install to)
vim arch-install.conf

Make script file executable
chmod +x arch-install.sh

Run script
./arch-install.sh
