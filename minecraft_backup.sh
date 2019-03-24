#!/usr/bin/env bash
# Minecraft Backup Script
# Written by Jesse N. Richardson (negativeflare@negativeflare.xyz) [negativeflare]

echo "This is a Minecraft Backup Script, it looks for the Minecraft tmux session"
echo "Then it looks for the 'papernut' folder, and backs it up"
echo "Then 7zips it up and puts it in the backups folder"

echo "NOTE: For this script to run properly you need the 7zip script in my misc_bash repo on Github"
echo "https://github.com/Flare183/misc_bash"

sleep 5

tmux send-keys -t Minecraft save-all C-m
sync
cp -Rv /home/minecraft/papernut /home/minecraft/papernut_"$(date +%F)"
echo "Running 7zip compress command"
/usr/local/bin/7zip /home/minecraft/Backups/papernut_"$(date +%F)".7z /home/minecraft/papernut_"$(date +%F)"
rm -Rv /home/minecraft/papernut_"$(date +%F)"

scp -l 7600 /home/minecraft/Backups/papernut_"$(date +%F)".7z jesse@desktop-vm:~/GDrive/Minecraft_Backups
