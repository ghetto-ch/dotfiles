#!/bin/sh

# Save the list of installed packages
pacman -Qqe > $HOME/.pkglist

# Incremental backup of home dir
bckdir="192.168.7.3:/pool1/Backups/gondolin/home"
rsync -aubh --delete --exclude=.protonvpn-cli --exclude=Downloads --backup-dir=bckfiles $HOME $bckdir --log-file=/mnt/Backups/gondolin/rsynclog --progress

# root partition image
#fsarchiver -j8 -o -A -v savefs /mnt/Backups/gondolin/root/archlinux.fsa DISK/PARTITION BY UUID??????
