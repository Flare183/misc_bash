#!/bin/bash
# iolite Minecraft Upload Script
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]
# This script should be ran at around 3AM

# Turn on break on error
set -e

# Make sure the rclone mounts are working
if [[ -d "/home/minecraft/GDrive/Minecraft_Backups" ]]; then
    echo "Google Drive Mounts Are Working"
fi
if [[ -d "/home/minecraft/OneDrive/Minecraft_Backups/" ]]; then
    echo "OneDrive Mounts Are Working"
fi

echo "All Drive Mounts are working, let's continue."

rsync -av --progress
