# Linux-software-collection
A small collection of Linux software that is installed via a script.
To use clone this repo, enter the directory and print in command prompt:
```bash
$ chmod +x ./Software_install.sh
$ ./Software_install.sh
```
Includes two installation options. Minimal and complete.

**Minimal includes**:
- Flatpak
- Snap
- Git
- Firefox
- Sublime text
- Qbittorrent
- yay (Arch only)

**Compete includes all minimal stuff and**:
- Ark
- VLC
- Telegram
- Discord 
- Libreoffice
- QEMU,libvrt and virt manager
- Wireguard

After complete instalation you must configure libvrt manually
```bash 
$ sudo nano /etc/libvirt/libvirtd.conf
```
and uncomment following two lines 
```
#unix_sock_group = “libvirt”
#unix_sock_ro_perms = “0777"
```
after that save file and exit.

T
