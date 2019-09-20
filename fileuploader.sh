#!/bin/bash
# Rat's Script to turn off and on the uploader
# Written by Jesse N. Richardson (negativeflare@negativeflare.xyz) [negativeflare]

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi


if [ $1 = "on" ]; then
  echo "Turning on File uploading..."
  mv /home/zachary/uploader/ /var/www/html/
fi

if [ $1 = "off" ]; then
  echo "Turning off File Uploading"
  mv /var/www/html/uploader/ /home/zachary/
fi
