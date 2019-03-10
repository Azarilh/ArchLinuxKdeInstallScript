#!/bin/bash

systemctl enable tor

# Disable Brave's error message
# sysctl kernel.unprivileged_userns_clone=1
# echo kernel.unprivileged_userns_clone = 1 | tee /etc/sysctl.d/00-local-userns.conf

# Downloading and installing custom locale
# git clone https://github.com/Azarilh/en_AZ
# cd en_AZ
# localedef -i en_AZ -f UTF-8 en_AZ.UTF-8 -c -v
# cp en_AZ /usr/share/i18n/locales/
# echo "en_AZ.UTF-8 UTF-8" >> /etc/locale.gen
# locale-gen

# Selecting language and locale
echo "" >> /etc/environment
echo "# Enable ibus." >> /etc/environment
echo 'export GTK_IM_MODULE=ibus' >> /etc/environment
echo 'export XMODIFIERS=@im=ibus' >> /etc/environment
echo 'export QT_IM_MODULE=ibus' >> /etc/environment
echo "" >> /etc/environment
echo "# Set language and locale" >> /etc/environment
echo 'export LANG="en_GB.UTF-8"' >> /etc/environment
echo 'export LC_ALL="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_TIME="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_NUMERIC="en_IE.UTF-8"' >> /etc/environment
echo 'export LC_CTYPE="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_COLLOCATE="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_MONETARY="en_IE.UTF-8"' >> /etc/environment
echo 'export LC_MESSAGES="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_PAPER="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_NAME="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_ADDRESS="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_TELEPHONE="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_MEASUREMENT="en_IE.UTF-8"' >> /etc/environment
echo '#export LC_INDENTIFICATION="en_IE.UTF-8"' >> /etc/environment
echo "" >> /etc/environment
echo "# KDE file chooser for GTK apps" >> /etc/environment
echo "export GTK_USE_PORTAL=1" >> /etc/environment
