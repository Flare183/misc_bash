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

cp /home/minecraft/Backups/papernut_"$(date +%F)".7z /home/minecraft/GDrive/

main_file=$(stat -c %s /home/minecraft/Backups/papernut_"$(date +%F)".7z)
remote_file=$(stat -c %s /home/minecraft/GDrive/papernut_"$(date +%F)".7z)

md5_main_file=$(md5sum --tag /home/minecraft/Backups/papernut_"$(date +%F)".7z | cut -d '=' -f 2-)
md5_remote_file=$(md5sum --tag /home/minecraft/GDrive/papernut_"$(date +%F)".7z | cut -d '=' -f 2-)

if [[ "$main_file" -ne "$remote_file" ]]; then
  echo "Files Sizes aren't the same, Trying again..."
  rm /home/minecraft/GDrive/papernut_"$(date +%F)".7z
  sleep 5
  sync
  cp /home/minecraft/Backups/papernut_"$(date +%F)".7z /home/minecraft/GDrive/
  sleep 10
  if [[ "$main_file" -ne "$remote_file" ]]; then
    echo "Files Sizes are STILL not the same, umounting and trying again."
    sleep 100
    fusermount -u /home/minecraft/GDrive
    # Finish this, I'm not done.
    ssh jesse@jade rm /home/jesse/GDrive/Minecraft_Backups/papernut_"$(date +%F)".7z
    ssh jesse@jade sync
    sleep 5
    scp -l 7600 /home/minecraft/Backups/papernut_"$(date +%F)".7z jesse@jade:~/GDrive/Minecraft_Backups
  fi
else
  echo "File Sizes Are Fine"
fi

if [[ "$md5_main_file" -ne "$md5_remote_file" ]]; then
  echo "Hashes aren't the same, trying again..."
  ssh jesse@jade rm /home/jesse/GDrive/Minecraft_Backups/papernut_"$(date +%F)".7z
  sleep 5
  ssh jesse@jade sync
  scp -l 7600 /home/minecraft/Backups/papernut_"$(date +%F)".7z jesse@jade:~/GDrive/Minecraft_Backups
  sleep 10
  if [[ "$md5_main_file" -ne "$md5_remote_file" ]]; then
    echo "Hashes are STILL not the same, rebooting, and trying again..."
    ssh jesse@jade sudo reboot
    sleep 300
    ssh jesse@jade rm /home/jesse/GDrive/Minecraft_Backups/papernut_"$(date +%F)".7z
    ssh jesse@jade sync
    sleep 5
    scp -l 7600 /home/minecraft/Backups/papernut_"$(date +%F)".7z jesse@jade:~/GDrive/Minecraft_Backups
  fi
else
    echo "File MD5 Sum Should Be Fine"
fi
