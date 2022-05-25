#!/bin/bash
##################################################################
# This script installs nessesary software on linux distro.       #
# Package manager doesn't matter. Sudo accses required.          #
##################################################################
cd ~
distro="null"
installtype="null"
# Install type 
while [[$installtype!="1" or $installtype!="2" ]]
    do
        echo "Please select the instalation type"
        echo "1 for minimal instalation. Includes: Flatpak, Snap, Git, Firefox, Sublime Text, Qbittorent, yay(Arch only)"
        echo "2 for complete instalaion. Includes: all minimal and Ark, VLC, Telegram, Discord, Libreoffice, QEMU+libvrt, Wireguard"
        read installtype
    done
 
# Package type 
if [ -f /usr/bin/apt ]
then 
    distro="deb"
fi
if [ -f /usr/bin/pacman ]
then
    distro="pacman"
fi
echo "Package type is $distro"

# Update and Upgrade 
if [[ $distro="deb" ]]
then
    sudo apt update && sudo apt upgrade 
fi
if [[ $distro="pacman" ]]
then 
    sudo pacman -Syu
fi 
# Flatpak 
if [[ $distro="deb"]]
then 
    sudo apt install flatpak
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S flatpak
fi
# Snap 
if [[ $distro="deb"]]
then 
    sudo apt install snapd
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S snapd
fi
# Git 
if [[ $distro="deb" ]]
then
    sudo apt install git
fi
if [[ $distro="pacman" ]]
then 
    sudo pacman -S git
    # I also need yay to grab some software from AUR
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si 
    cd .. 
fi 

# Firefox
if [[ $distro="deb" ]]
then
    sudo apt install firefox
fi
if [[ $distro="pacman" ]]
then
    sudo pacman -S firefox

# Sublime text
if [[ $distro="deb" ]]
then
    # GPG Key
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    # Http sources 
    sudo apt-get install apt-transport-https
    # Add chanel
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    # Update sources and install 
    sudo apt-get update
    sudo apt-get install sublime-text
fi 
if [[ $distro="pacman" ]]
then 
    # GPG Key
    curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
    # Add channel 
    echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
    # Update sources and install 
    sudo pacman -Syu sublime-text

# Qbittorrent 
if [[ $distro="deb"]]
then 
    sudo apt install qbittorrent 
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S qbittorrent
fi
# Procced to complete instalation
if [[$installtype="1"]]
then 
    echo "MINIMAL INSTALATION COMPLETED. PRESS ENTER TO EXIT"
    read $anything 
    exit 
fi

# Ark 
if [[ $distro="deb"]]
then 
    sudo apt install ark
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S ark
fi

# VLC
if [[ $distro="deb"]]
then 
    sudo apt install vlc
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S vlc
fi

# Telegram flatpak
flatpak install flathub org.telegram.desktop

# Discord 
if [[ $distro="deb"]]
then 
    sudo snap install discord
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S discord 
fi

# Libreoffice 
if [[ $distro="deb"]]
then 
    sudo snap install libreoffice
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S libreoffice-still
fi
# QEMU and libvrt
if [[ $distro="deb"]]
then 
    sudo apt install virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
fi 
if [[ $distro="pacman"]]
then 
    sudo pacman -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils netcat
fi
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service 
# Please configure libvrt manually
# sudo nano /etc/libvirt/libvirtd.conf
# Uncomment the follow two lines: 
#   #unix_sock_group = “libvirt”
#   #unix_sock_ro_perms = “0777”

# Wireguard
if [[ $distro="deb"]]
then 
    sudo apt install wireguard
fi 
if [[ $distro="pacman"]] # Resolvconf may be needed
then 
    sudo pacman -S wireguard resolvconf
fi
echo "Don't forget to configure libvrt. sudo nano /etc/libvirt/libvirtd.conf and uncomment #unix_sock_group = “libvirt” and #unix_sock_ro_perms = “0777"

