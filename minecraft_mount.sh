#!/usr/bin/env bash
# Minecraft Mount Script
# Written by Jesse N. Richardson (negativeflare@negativeflare.xyz) [negativeflare]

sshfs jesse@iolite:/mnt/Backup/Minecraft_Backups/ Backups/
sshfs jesse@kyanite:/home/jesse/papernut papernut
rclone mount --daemon GDrive:Minecraft_Backups/ /home/minecraft/GDrive/
