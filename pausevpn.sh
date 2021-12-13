#!/usr/bin/env bash

#nordvpn cli doesn't have a pause feature, so I'll write my own

vpnstatus=$(nordvpn status | head -1 | awk -F': ' '{print $2}')

if [[ $vpnstatus = "Disconnected" ]]; then
    notify-send "Nordvpn already disconnected, will not restart."
    exit 0;
fi

if [[ -z $1 ]]; then
    duration=$(echo "" | dmenu -p "For how long do you want to pause nordvpn? (minutes)")
    notify-send "will pause for $duration minutes.\n Don't kill the script in the meantime"
fi

nordvpn disconnect
sleep ${duration}m
notify-send "You will now be reconnected to nordvpn"
nordvpn connect
