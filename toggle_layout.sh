#!/usr/bin/env bash
#
#Script to quickly toggle between us and de layout
#Alternatively an argument can be given which specifies the layout to use
#Lukas Neugebauer, 20-01-2022

#check if an argument was given
if [[ -n $1 ]]; then
    setxkbmap -layout $1 || (notify-send -u critical "Couldn't set layout to $1" && exit 1)
    notify-send "set layout to $1" && exit 0
fi

#get current layout
current=$(setxkbmap -query | grep layout | cut -d: -f2 | sed 's/\s//g')

#switch to us if de and vice versa
if [[ $current = de ]]; then
    setxkbmap -layout us
    notify-send "Switched to us layout"
elif [[ $current = us ]]; then
    setxkbmap -layout de
    notify-send "Switched to de layout"
else
    notify-send "Don't know what to switch to, sorry"
fi
