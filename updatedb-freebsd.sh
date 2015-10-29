#!/bin/bash

# UpdateDB for FreeBSD
# Run /etc/periodic/weekly/310.locate

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi

/etc/periodic/weekly/310.locate
