#!/usr/bin/env bash
#
#Bash script using dmenu to choose a hard drive and location for mounting

#ask which drive to mount. it's looking for all sd[a-z][0-9] drives
drive=$(lsblk -i | grep 'sd[a-z][0-9]' | tr '`-' ' ' | sed 's/\s\+/ /g' | awk '{printf "%s: %s\n", $1, $4}' | dmenu -i -p "Mount which drive?")
drive="/dev/${drive%:*}"
#if none is given, exit
[[ -z $drive ]] && exit 0

#ask for the mountingpoint
mountpoint=/mnt/$(ls /mnt | dmenu -i -p "Choose mountpoint")

#create if it doesn't exist
[[ ! -d "$mountpoint" ]] && mkdir "$mountpoint"

#mount hardrive with user ownership
sudo mount -o uid=$UID,gid=1000 $drive $mountpoint && notify-send "Mounted $drive to $mountpoint" && exit
notify-send -u critical "Couldn't mount
