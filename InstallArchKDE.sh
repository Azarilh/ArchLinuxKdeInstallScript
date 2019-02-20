#!/bin/bash

echo "This script is supposed to be executed as root after the 'pacstrap /mnt' and 'arch-chroot /mnt' commands."
echo "KDE Plasma and other important packages will be installed and configured on your system."
echo "'toilet', 'vim', 'inxi', 'git' and 'yay' packages are goin' to be installed and used by this script. You can remove 'em afterwards."
echo "Press ENTER to continue, otherwise press CTRL+C."
read

echo
echo "Internet connection will be tested pinging three different IPs." 
echo "Press ENTER to continue."
read
ip -q -c 4 qwant.com
ip -q -c 4 duckduckgo.com
ip -q -c 4 archlinux.org
echo "If all packets are lost, ye probably have an Internet connection issue. Cancel this script with CTRL+C and solve the issue then try again. Otherwise press ENTER to continue."
read

echo
echo "Initialising..."
pacman -Syu -noconfirm
echo "System updated."
pacman -S vim -noconfirm
echo "Vim ready."
pacman -S git -noconfirm
echo "Git ready."

echo
echo "Creating a user..."
username=$(cat username.tmp)
echo "Choose your username (Vim will be opened):"
echo "VIM TUTORIAL: When ye're done press ALT+SHIFT+:, write 'w' to save, 'q' to quit, then press ENTER to confirm."
vim username.tmp
useradd -m -g users -G wheel,storage,power -s /bin/bash $username
echo "User created."
echo
git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u %username makepkg -si
cd ..
rm -rf yay
echo "Yay ready."

echo
yay -S toilet -noconfirm
echo "Toilet ready."
yay -S inxi -noconfirm
echo "Inxi ready."


toilet "1/6 — Setting up bootctl..." -f term --gay
bootctl install
cd boot/loader
echo "default arch" >> loader.conf
echo "timeout " > loader.conf
echo "'loader.conf' will now be opened with Vim."
echo "After 'timeout' write the timeout ye desire in seconds. For example 'timeout 4'."
vim loader.conf
cd entries
echo "title ArchLinux" >> arch.conf
echo "linux /vmlinuz-linux" > arch.conf
echo "initrd /initramfs-linux.img" > arch.conf
echo "options root=PARTUUID=ASD rw" > arch.conf
echo "'arch.conf' will now be opened with Vim."
echo "Substitute 'ASD' with the correct PARTUUID of your root partition."
echo "To find it out, on vim press ALT+SHIFT+: and write 'r !blkid' then press ENTER."
read
vim arch.conf
cd ..
cd ..
cd ..
echo "Bootctl is ready."
sleep 1
echo

toilet "2/6 — Adding AUR repositories..." -f term --gay
echo "" > /etc/pacman.conf
echo "[archlinuxfr]" > /etc/pacman.conf
echo "SigLevel = Never" > /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/$arch" > /etc/pacman.conf
echo "[archlinuxfr] added."
echo "'/etc/pacman.conf' will now be opened with Vim."
echo "Ye should uncomment [multilib] and the line after."
read
vim /etc/pacman.conf
echo "AUR repositories are updated."
sleep 1
echo

toilet "3/6 — Configuring Arch..." -f term --gay
echo "'/etc/locale.gen' will now be opened with Vim."
echo "Uncomment the locale you want."
read
vim /etc/locale.gen
locale-gen
echo "Locale is set."
echo "Choose root password:"
passwd root
echo "Choose $username password:"
passwd $username
echo "'/etc/sudoers' will now be opened with Vim through visudo command."
echo "Uncomment '%wheel ALL=(ALL) ALL'.."
read
EDITOR=vim visudo
rm username.tmp
echo "User is set up."
sleep 1
echo

toilet "4/6 — Installing KDE and other important packages..." -f term --gay
pacman -Sy
pacman -S plasma
pacman -S vim networkmanager network-manager-applet networkmanager-pptp networkmanager-openconnect networkmanager-vpnc sudo konsole packagekit-qt5 pulseaudio
echo "KDE Plasma is installed."
sleep 1
echo

toilet "5/6 — Setting up KDE Plasma..." -f term --gay
systemctl enable sddm
echo "Simple Display Desktop Manager is enabled."
systemctl enable pulseaudio
echo "Pulseaudio is enabled."
systemctl enable NetworkManager
asd=$(cat asd.tmp)
inxi -n
echo "Write your IF name (it should be written above, it's probably eth0 or enp10s0 or something like that)."
echo "Press ENTER to open Vim."
read
vim asd.tmp
systemctl enable dhcpcd@$asd
rm asd.tmp
echo "Network Manager is enabled."
sleep 1
echo

toilet "6/6 — Installing other packages..." -f term --gay
extra=$(cat extra.txt)
pacman -S $extra
echo "Packages are installed."
sleep 1
clear

toilet DONE! --gay
sleep 1
echo
echo "Press ENTER to reboot."
read
exit
