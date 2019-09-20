#!/bin/bash

# Laptop Installer Script
# Written by Jesse N. Richardson (flare183@nctv.com) [negativeflare]


if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi

sudo apt install htop zsh terminator audacious vlc gigolo hexchat thunderbird speedcrunch k3b git milkytracker xiphos synaptic gparted
