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
sleep 10
sync
cp -Rv /home/minecraft/papernut /mnt/Secondary/Minecraft_Compress/papernut_"$(date +%F)"
echo "Running 7zip compress command"
/usr/local/bin/7zip /home/minecraft/Backups/papernut_"$(date +%F)".7z /mnt/Secondary/Minecraft_Compress/papernut_"$(date +%F)"
rm -Rv /mnt/Secondary/Minecraft_Compress/papernut_"$(date +%F)"

scp -l 7600 /home/minecraft/Backups/papernut_"$(date +%F)".7z jesse@desktop-vm:~/GDrive/Minecraft_Backups

main_file=$(stat -c %s /home/minecraft/Backups/papernut_"$(date +%F)".7z)
remote_file=$(ssh jesse@desktop-vm stat -c %s /home/jesse/GDrive/Minecraft_Backups/papernut_"$(date +%F)".7z)
if [[ "$main_file" -ne "$remote_file" ]]; then
  scp -l 7600 /home/minecraft/Backups/papernut_"$(date +%F)".7z jesse@desktop-vm:~/GDrive/Minecraft_Backups
  if [[ "$main_file" -ne "$remote_file" ]]; then
    ssh jesse@desktop-vm sudo reboot
    sleep 300
    ssh jesse@desktop-vm rm /home/jesse/GDrive/Minecraft_Backups/papernut_"$(date +%F)".7z
    ssh jesse@desktop-vm sync
    sleep 5
    scp -l 7600 /home/minecraft/Backups/papernut_"$(date +%F)".7z jesse@desktop-vm:~/GDrive/Minecraft_Backups
  fi
else
  echo "Files are fine."
fi
