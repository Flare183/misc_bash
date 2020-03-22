#!/usr/bin/env bash
# Minecraft Backup Script
# Written by Jesse N. Richardson (negativeflare@negativeflare.xyz) [negativeflare]

echo "This is a Minecraft Backup Script, it looks for the Minecraft tmux session"
echo "Then it looks for the 'papernut' folder, and backs it up"
echo "Then 7zips it up and puts it in the backups folder"
echo "This Script backs up the Typhlosion Server to Google Drive as well"

echo "NOTE: For this script to run properly you need the 7zip script in my misc_bash repo on Github"
echo "https://github.com/Flare183/misc_bash"

sleep 5

#echo "Setting up new log file"
#date -R >> /var/log/minecraft_backup/minecraft_backup.log


tmux send-keys -t Minecraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 5 C-m
sleep 60
tmux send-keys -t Minecraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 4 C-m
sleep 60
tmux send-keys -t Minecraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 4 C-m
sleep 60
tmux send-keys -t Minecraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 3 C-m
sleep 60
tmux send-keys -t Minecraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 2 C-m
sleep 60
tmux send-keys -t Minecraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 1 C-m
sleep 60
tmux send-keys -t Minecraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ NOW C-m
sleep 15


tmux send-keys -t Minecraft save-all C-m
sleep 10
tmux send-keys -t Minecraft stop C-m
sleep 50
sync
cp -Rv /home/minecraft/papernut /home/minecraft/Minecraft_Compress/papernut-typhlosion_"$(date +%F)"
echo "Running 7zip compress command"
/usr/local/bin/7zip /home/minecraft/papernut_"$(date +%F)".7z /mnt/Secondary/Minecraft_Compress/papernut-typhlosion_"$(date +%F)"
rm -Rv /mnt/Secondary/Minecraft_Compress/papernut_"$(date +%F)"

echo "Uploading File for the first time..."
cp /home/minecraft/papernut-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/

main_file=$(stat -c %s /home/minecraft/papernut-typhlosion_"$(date +%F)".7z)
remote_file=$(stat -c %s /home/minecraft/GDrive/papernut-typhlosion_"$(date +%F)".7z)

main_file_second_check=$(stat -c %s /home/minecraft/papernut-typhlosion_"$(date +%F)".7z)
remote_file_second_check=$(stat -c %s /home/minecraft/GDrive/papernut-typhlosion_"$(date +%F)".7z)

if [[ "$main_file" -ne "$remote_file" ]]; then
  echo "Files Sizes aren't the same, Trying again..."
  rm /home/minecraft/GDrive/papernut-typhlosion_"$(date +%F)".7z
  sleep 5
  sync
  cp /home/minecraft/papernut-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
  sleep 10
  if [[ "$main_file_second_check" -ne "$remote_file_second_check" ]]; then
    echo "Files Sizes are STILL not the same, umounting and trying again."
    sleep 100
    fusermount -u /home/minecraft/GDrive
    rclone mount --daemon GDrive:Minecraft_Backups/ /home/minecraft/GDrive/
    sleep 10
    ls /home/minecraft/GDrive/
    rm /home/minecraft/GDrive/papernut-typhlosion_"$(date +%F)".7z
    sync
    sleep 5
    cp -v /home/minecraft/papernut-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
  fi
else
  echo "File Sizes Are Fine"
fi

md5_main_file=$(md5sum --tag /home/minecraft/papernut-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)
md5_remote_file=$(md5sum --tag /home/minecraft/GDrive/papernut-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)

md5_main_file_second_check=$(md5sum --tag /home/minecraft/papernut-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)
md5_remote_file_second_check=$(md5sum --tag /home/minecraft/GDrive/papernut-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)

if [ "$md5_main_file" == "$md5_remote_file" ]; then
  echo "File Hashes are fine."
else
    echo "Hashes aren't the same, trying again..."
    rm /home/jesse/GDrive/papernut-typhlosion_"$(date +%F)".7z
    sleep 5
    sync
    cp -v /home/minecraft/papernut-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
    sleep 10
  if [ "$md5_main_file_second_check" == "$md5_remote_file_second_check" ]; then
    echo "File Hashes are fine"
    else
      echo "Hashes are STILL not the same, umounting and trying again..."
      sleep 100
      fusermount -u /home/minecraft/GDrive/
      rclone mount --daemon GDrive:Minecraft_Backups/ /home/minecraft/GDrive/
      rm /home/jesse/GDrive/Minecraft_Backups/papernut-typhlosion_"$(date +%F)".7z
      sync
      sleep 5
      cp -v /home/minecraft/Backups/papernut-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
  fi
fi

# Start the Server backup
cd /home/minecraft/papernut/
#tmux new -d -s Minecraft java -jar paper-214.jar
tmux new -d -s Minecraft java -Xms4096M -Xmx4096M -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -jar paper-137.jar
