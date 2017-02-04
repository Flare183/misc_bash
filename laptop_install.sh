#!/bin/bash

# Laptop Installer Script
# Written by Jesse N. Richardson (flare183@nctv.com) [negativeflare]


if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi

apt-get update
apt-get install htop zsh terminator audacious vlc gigolo hexchat claws-mail speedcrunch k3b gnome-do docky git git-cola emacs24 emacs-goodies-el slime sbcl milkytracker xiphos sound-converter synaptic gparted
