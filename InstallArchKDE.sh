#!/bin/bash

clear
echo "InstallArchKDE.sh — Version 1.02"
sleep 1

dir=$(pwd)

clear
echo "IMPORTANT: This script is supposed to be executed as root after the 'pacstrap /mnt' and 'arch-chroot /mnt' commands."
sleep 3
echo "Press ENTER to continue."
read
clear
echo "ALSO IMPORTANT: Using this script is YOUR full responsability!"
echo "I don't assume any responsability in regards of the usage of my script."
echo "Using it, you agree that it's your full responsability whatever will happen to your computer device."
echo "If you don't want to risk try it first on a virtual machine or an unused/unimportant computer or open the script with a text editor and check if it's what you want."
echo "You can edit it and share it edited or not edited. The copyright is GNU General Public Licence v3."
read
echo
echo "PRESSING ENTER YOU AGREE THAT IT'S YOUR FULL RESPONSABILITY!"
sleep 2
echo "Press ENTER to continue."
read
clear
echo "KDE Plasma and other important packages will be installed and configured on your system."
read
echo "'toilet', 'vim', 'inxi', 'git', 'sudo' and 'yay' packages are goin' to be installed and used by this script. You can remove 'em afterwards."
read
echo "Edit the 'extra.txt' file to choose what extra packages to install (ye can do it afore the last phase of the installation begins)."
read
echo "Ye should set your keyboard layout afore (so you don't mess up the passwords you'll set). Use the 'loadkeys' command. Example: 'loadkeys it' for Italian layout."
echo "The default is US. Available layouts can be listed with the command 'ls /usr/share/kbd/keymaps/**/*.map.gz'."
echo "Ye can search writing 'ls /usr/share/kbd/keymaps/**/*SRC*.map.gz' where 'SRC' is the language. For example 'ls /usr/share/kbd/keymaps/**/*it*.map.gz'."
read
echo "Press ENTER to continue, otherwise press CTRL+C."
read

echo
echo "Internet connection will be tested pinging three different IPs." 
echo "Press ENTER to continue."
read
echo
ping -q -c 4 qwant.com
echo
echo
ping -q -c 4 reddit.com
echo
echo
ping -q -c 4 archlinux.org
echo
echo
echo "If all packets are lost, ye probably have an Internet connection issue. Cancel this script with CTRL+C and solve the issue then try again. Otherwise press ENTER to continue."
read

clear
echo "Initialising..."
pacman -Syu --noconfirm
echo "System: updated."
pacman -S vim --noconfirm
echo "Vim: ready."
pacman -S git --noconfirm
echo "Git: ready."
pacman -S sudo --noconfirm
echo "Sudo: ready."
pacman -S base-devel --noconfirm
echo "Makepkg: ready."

echo
echo "Creating a user..."
echo
echo "Choose your username (Vim will be opened):"
echo "The username MUST be simple. No capital letters allowed. It should be between 1 to 32 charcters long."
echo "Do not use dots. Do not end it in dash. It must not include colons."
echo
echo "VIM TUTORIAL: When ye're done press ALT+SHIFT+:, write 'w' to save, 'q' to quit, then press ENTER to confirm."
echo "Press ENTER to open Vim."
read
vim username.tmp
username=$(cat username.tmp)
useradd -m -g users -G wheel,storage,power -s /bin/bash $username
echo
echo "Choose $username password:"
passwd $username
echo "User created."
echo
git clone https://aur.archlinux.org/yay.git
echo
echo "'/etc/sudoers' will now be opened with Vim through visudo command."
echo "Uncomment (remove #) '%wheel ALL=(ALL) ALL'.."
echo "Press ENTER to open Vim."
read
EDITOR=vim visudo
cd yay
sudo -u $username makepkg -si
cd ..
rm -rf yay
echo "Yay: ready."

echo
sudo -u $username yay -S toilet --noconfirm
echo "Toilet: ready."
sudo -u $username yay -S inxi --noconfirm
echo "Inxi: ready."
echo
echo "Press ENTER to continue to next phase."
read

clear
toilet "1/6 — Setting up bootctl..." -f term --gay
bootctl install
cd /
cd boot/loader
echo "default arch" > loader.conf
echo "timeout " >> loader.conf
echo
echo "'loader.conf' will now be opened with Vim."
echo "After 'timeout' write the timeout ye desire in seconds. For example 'timeout 4'."
echo "This is how long you want to wait until bootctl selects automatically the boot option."
echo "Press ENTER to open Vim."
read
vim loader.conf
cd entries
echo "title ArchLinux" > arch.conf
echo "linux /vmlinuz-linux" >> arch.conf
echo "initrd /initramfs-linux.img" >> arch.conf
echo "options root=PARTUUID=ASD rw" >> arch.conf
echo
echo "'arch.conf' will now be opened with Vim."
echo "Substitute 'ASD' with the correct PARTUUID of your root partition."
echo "To find it out, on vim press ALT+SHIFT+: and write 'r !blkid' then press ENTER."
echo "Press ENTER to open Vim."
read
vim arch.conf
cd /
echo "Bootctl: ready."
echo
echo "Press ENTER to continue to the next phase."
read

clear
toilet "2/6 — Adding AUR repositories..." -f term --gay
echo "" >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo -n "Server = http://repo.archlinux.fr/$" >> /etc/pacman.conf && echo "arch" >> /etc/pacman.conf
echo "[archlinuxfr] added."
echo
echo "'/etc/pacman.conf' will now be opened with Vim."
echo "Ye MUST uncomment [multilib] and the line after."
echo "Press ENTER to open Vim."
read
vim /etc/pacman.conf
echo "AUR repositories are updated."
echo
echo "Press ENTER to continue to the next phase."
read

clear
toilet "3/6 — Configuring Arch..." -f term --gay
echo
echo "'/etc/locale.gen' will now be opened with Vim."
echo "Uncomment the locale you want."
echo "Press ENTER to open Vim."
read
vim /etc/locale.gen
locale-gen
echo "Locale is set."
echo
echo "Choose root password:"
passwd root
cd $dir
rm username.tmp
echo "Arch configured."
echo
echo "Press ENTER to continue to the next phase."
read

clear
toilet "4/6 — Installing KDE and other important packages..." -f term --gay
pacman -Sy
pacman -S plasma
pacman -S vim networkmanager network-manager-applet networkmanager-pptp networkmanager-openconnect networkmanager-vpnc sudo konsole packagekit-qt5 pulseaudio
echo "KDE Plasma is installed."
echo
echo "Press ENTER to continue to the next phase."
read

clear
toilet "5/6 — Setting up KDE Plasma..." -f term --gay
systemctl enable sddm
echo "Simple Display Desktop Manager is enabled."
systemctl enable pulseaudio
echo "Pulseaudio is enabled."
systemctl enable NetworkManager
echo "Network Manager is enabled."
echo
echo "Press ENTER to continue to the next phase."
read

clear
toilet "6/6 — Installing other packages..." -f term --gay
echo "'extra.txt' will be now opened with Vim."
echo "Add or remove packages that you want to install from official Arch repositories."
echo "Do not add packages that don't exist, this would cancel the installation of all the other packages."
echo "NOTE: Konsole has been already installed! It's important to have at least one terminal emulator."
echo "Press ENTER to open Vim."
read
vim extra.txt
extra=$(cat extra.txt)
pacman -Sy $extra
echo
echo "extra2.txt will be now opened with Vim."
echo "Add or remove packages that you want to install from AUR repositories."
echo "Press ENTER to open Vim."
read
vim extra2.txt
extra2=$(cat extra2.txt)
sudo -u $username yay -Sy $extra2
echo "Packages are installed."
echo "Press ENTER to continue to the next phase."
read

clear
toilet "Optional — Execute your own script."
chmod 777 extra3.sh
echo "'extra3.sh' will be now opened with Vim."
echo "Add your own script, if ye want. It will be executed immediately after you close Vim."
echo "Press ENTER to open Vim."
read
vim extra3.sh
./extra3.sh

clear
toilet DONE! --gay
sleep 2
echo
echo "Hey,"
echo "thank you for using this script."
sleep 2
echo "Contact me on the GitHub page for feedback."
echo "github.com/Azarilh/ArchLinuxKdeInstallScript"
sleep 2
echo "Have a nice day!"
sleep 2
echo
echo "Press ENTER to exit."
read
exit
