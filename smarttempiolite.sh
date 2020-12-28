#!/bin/bash
# SMART Temp Display Script for iolite
# Written by Jesse N. Richardson

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi

hard_drives=$(ls /dev/sd[a-g])
for devices in $hard_drives;
do
  smartctl -a $devices | grep Temperature_Celsius
done
