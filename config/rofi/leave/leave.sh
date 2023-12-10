#!/usr/bin/env bash

choice=$(printf "Logout\nSuspend\nReboot\nShutdown" | rofi -dmenu)
if [[ $choice == "Lock" ]];then
    bash ~/.config/system_scripts/wayland_session_lock
elif [[ $choice == "Logout" ]];then
    pkill -KILL -u "$USER"
elif [[ $choice == "Suspend" ]];then
    systemctl suspend
elif [[ $choice == "Reboot" ]];then
    systemctl reboot
elif [[ $choice == "Shutdown" ]];then
    systemctl poweroff
elif [[ $choice == "Portrait" ]];then
    hyprctl keyword monitor ,preferred,auto,1.5,transform,1
elif [[ $choice == "Landscape" ]];then
    hyprctl keyword monitor ,preferred,auto,1.5
fi
