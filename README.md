# ArchLinuxKdeInstallScript

This script auto installs Arch on the partition you mounted on /mnt.
Remember to mount the boot partition as well on /mnt/boot so the script could install bootctl, a grub alternative.
If you don't want the script to install bootctl, edit the script commenting (adding # at the beginning of the line) from line 111 to line 141.
It also installs KDE Plasma and some important packages (networkmanager network-manager-applet networkmanager-pptp networkmanager-openconnect networkmanager-vpnc sudo konsole). You can change these packages from line 181.
SDDM, Pulseaudio and NetworkManager will be enabled (lines 191-201).
From line 203, packages written in the extra.txt and extra2.txt files will be installed.
extra.txt are packages from official repositories, extra2.txt are packages from AUR repositories (installed with yay).
From line 226, a custom script will be executed (extra3.sh). Per default, for example, it enables Tor at Arch startup.

All what you need to do is following the script's indications, when manual configuration is needed.
It's important that you follow all the steps correctly, otherwise something may not be done correctly afterwards.
For example: the program will ask you to choose a username, it must be a username that Linux can handle (f.e. capital letters are not allowed), otherwise the script will not create a user, which means that it will not install AUR packages (they can't be installed with root user)
This script is really simple, it doesn't use conditional commands (if, then, etc.), which is why you shouldn't make mistakes.

This script is supposed to be executed as root after the 'pacstrap /mnt' and 'arch-chroot /mnt' commands.
Of course afore that you would need to mount at least the root partition and the boot partition (except if you don't want to install any boot manager).
If you don't have these partitions ready, create them with gdisk, fdisk or parted (and some other tools as well). A fast tutorial can be found in the WhatToDoBefore.txt file.

And that's it. :)
