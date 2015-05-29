#!/bin/bash

# First off we check if the user is running this via root
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi

apt-get update
aptitude upgrade
