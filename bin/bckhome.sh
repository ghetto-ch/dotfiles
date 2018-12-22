#!/bin/sh

# Save the list of installed packages
pacman -Qqe > /home/ghetto/.pkglist

# Incremental backup of home dir
rsync -aubh --delete --exclude=.protonvpn-cli --exclude=Downloads --backup-dir=bckfiles /home/ghetto 192.168.7.3:/pool1/Backups/gondolin/home --log-file=/mnt/Backups/gondolin/rsynclog --progress

# root partition image
#fsarchiver -j8 -o -A -v savefs /mnt/Backups/gondolin/root/archlinux.fsa DISK/PARTITION BY UUID??????
