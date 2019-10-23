#!/usr/bin/env bash
# Minecraft Mount Script
# Written by Jesse N. Richardson (negativeflare@negativeflare.xyz) [negativeflare]

sshfs jesse@iolite:/mnt/Backup/Minecraft_Backups/ Backups/
rclone mount --daemon GDrive:Minecraft_Backups/ /home/minecraft/GDrive/
