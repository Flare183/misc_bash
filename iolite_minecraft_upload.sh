#!/bin/bash
# iolite Minecraft Upload Script
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]
# This script should be ran at around 3AM

# Turn on break on error
set -e

# Make sure the rclone mounts are working
if [[ -d "/home/jesse/GDrive/Minecraft_Backups/" ]]; then
    echo "Google Drive Mount is Working"
else
    echo "Google Drive Mount is not working"
    break
fi

if [[ -d "/home/minecraft/OneDrive/Minecraft_Backups/" ]]; then
    echo "OneDrive Mount is Working"
else
    echo "OneDrive Mount is not working"
    break
fi

if [[ -d "/home/jesse/Mega/Minecraft_Backups/" ]]; then
    echo "Mega Drive Mount is Working"
else
    echo "Mega Drive Mount is not working"
    break
fi

echo "All Drive Mounts are working, let's continue."

# Let's check for the required space on each drive, if there's enough space copy the file over.

requiredspace=11264000
gdrive_space=$(df /home/jesse/GDrive | awk 'NR==2 { print $4 }')
onedrive_space=$(df /home/jesse/OneDrive | awk 'NR==2 { print $4 }')
megadrive_space=$(df /home/jesse/Mega | awk 'NR==2 { print $4 }')



if [[ ]]


rsync -av --progress
