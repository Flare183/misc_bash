#!/bin/bash
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]
# This Script is used to show the jails and their statuses


if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "Run this with sudo bash <filename>"
   exit 1
fi

JAILS=`fail2ban-client status | grep "Jail list" | sed -E 's/^[^:]+:[ \t]+//' | sed 's/,//g'`
for JAIL in $JAILS
do
  fail2ban-client status $JAIL
done
