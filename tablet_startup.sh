#!/bin/bash

# Bash Script to setup all the wireless stuff for the Tablet

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi

echo "Removing e100..."
rmmod e100
echo "Removed e100"
sleep 5
echo "Configuring Wireless..."
iwconfig eth1 essid "ISLER-DS"
dhclient eth1
echo "Done Configuring Wireless"
echo "Activating Extra Swap..."
swapon /dev/sdb1
echo "Swap enabled from 4GB Flash Drive"
echo "Script completed"
