#!/usr/bin/env bash
#nordvpn cli doesn't have a pause feature, so I'll write my own
#this script relies on the nordvpn-cli utility, notify-send and dmenu
#Lukas Neugebauer, 2021-12-13

#check connectio status, we're not doing anything if there's no connection
vpnstatus=$(nordvpn status | head -1 | awk -F': ' '{print $2}')
if [[ $vpnstatus = "Disconnected" ]]; then
    notify-send "Nordvpn already disconnected, will not restart."
    exit 0;
fi

#figure out duration
duration=$1
if [[ -z $duration ]]; then
    duration=$(echo "" | dmenu -p "For how long do you want to pause nordvpn? (minutes)")
fi
notify-send "will pause for $duration minutes.\n Don't kill the script in the meantime"

#disconnect, wait for duration and reconnect
nordvpn disconnect
sleep ${duration}m
notify-send "You will now be reconnected to nordvpn"
nordvpn connect
