# ArchLinuxKdeInstallScript
<hr>
This script auto configures Arch and installs KDE Plasma on the partition you mounted on /mnt.<br>
It's made for personal use, but if someone want to use it, they're free to do so.<br><br>

Remember to mount the boot partition as well on /mnt/boot so the script could install bootctl, a grub alternative.<br>
If you don't want the script to install bootctl, edit the script commenting (adding # at the beginning of the line) from line 110 to line 140.<br>
It also installs some important packages (networkmanager network-manager-applet networkmanager-pptp networkmanager-openconnect networkmanager-vpnc sudo konsole). You can change these packages from line 181.<br>
SDDM, Pulseaudio and NetworkManager will be enabled (lines 192-205).<br>
From line 207, packages written in the extra.txt and extra2.txt files will be installed.<br>
extra.txt are packages from official repositories, extra2.txt are packages from AUR repositories (installed with yay).<br>
From line 230, a custom script will be executed (extra3.sh). Per default, for example, it enables Tor at Arch startup.<br>
<br>
All what you need to do is following the script's indications, when manual configuration is needed.<br>
It's important that you follow all the steps correctly, otherwise something may not be done correctly afterwards.<br>
For example: the program will ask you to choose a username, it must be a username that Linux can handle (f.e. capital letters are not allowed), otherwise the script will not create a user, which means that it will not install AUR packages (they can't be installed with root user).<br>
You can download this script directly with Arch live-USB with these commands (after you used the 'arch-chroot /mnt' command):<br>
		$ pacman -Sy git   #To install git<br>
		$ git clone https://github.com/Azarilh/ArchLinuxKdeInstallScript   #To download this github<br>
		$ cd ArchLinuxKdeInstallScript   #To enter the folder ye just downloaded<br>
		$ chmod 777 InstallArchKDE.sh   #To make the script be executable<br>
		$ ./InstallArchKDE.sh   #To execute the script<br><br>
This script is really simple, it doesn't use conditional commands (if, then, etc.), which is why you shouldn't make mistakes.<br>
<br>
This script is supposed to be executed as root after the 'pacstrap /mnt' and 'arch-chroot /mnt' commands.<br>
Of course afore that you would need to mount at least the root partition and the boot partition (except if you don't want to install any boot manager).<br>
If you don't have these partitions ready, create them with gdisk, fdisk or parted (and some other tools as well). A fast tutorial can be found in the WhatToDoBefore.txt file.<br>
<br>
And that's it. :)
