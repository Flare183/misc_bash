#!/bin/bash
# Vnstat Graph Generator and copying script

/usr/bin/vnstati -vs -i eth0 -o /tmp/vnstat-desktop.png
scp /tmp/vnstat-desktop.png jesse@quartz:/var/www/vnstat/
