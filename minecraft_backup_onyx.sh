#!/usr/bin/env bash
# Minecraft Backup Script
# Written by Jesse N. Richardson (negativeflare@negativeflare.xyz) [negativeflare]

echo "This is a Minecraft Backup Script, it looks for the Minecraft tmux session"
echo "Then it looks for the 'crazycraft' folder, and backs it up"
echo "Then 7zips it up and puts it in the backups folder"

echo "NOTE: For this script to run properly you need the 7zip script in my misc_bash repo on Github"
echo "https://github.com/Flare183/misc_bash"

sleep 5

echo "Setting up new log file"
touch /var/log/minecraft_backup/minecraft_backup.log
date -R >> /var/log/minecraft_backup/minecraft_backup.log


tmux send-keys -t crazycraft say\ CC:\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 5 C-m
sleep 60

tmux send-keys -t crazycraft say\ CC:\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 4 C-m
sleep 60

tmux send-keys -t crazycraft say\ CC:\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 3 C-m
sleep 60

tmux send-keys -t crazycraft say\ CC:\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 2 C-m
sleep 60

tmux send-keys -t crazycraft say\ CC:\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 1 C-m
sleep 60


tmux send-keys -t crazycraft save-all C-m
sleep 10

tmux send-keys -t crazycraft stop C-m
sleep 50
sync

mkdir /mnt/Secondary/Minecraft_Compress/crazycraft_onyx_"$(date +%F)"/
rsync -av --progress /mnt/WDBlueSSD/Minecraft/crazycraft/ /mnt/Secondary/Minecraft_Compress/crazycraft_onyx_"$(date +%F)"/
sync
sleep 10

echo "Running 7zip compress command"
/usr/local/bin/7zip /mnt/500GB/CC_Backup/crazycraft_onyx_"$(date +%F)".7z /mnt/Secondary/Minecraft_Compress/crazycraft_onyx_"$(date +%F)"
sleep 30
rm -Rv /mnt/Secondary/Minecraft_Compress/crazycraft_onyx_"$(date +%F)"/
sync
sleep 20


# Start the Server backup
cd /mnt/WDBlueSSD/Minecraft/crazycraft/
tmux new -d -s crazycraft /usr/lib/jvm/java-8-openjdk-amd64/bin/java -Dlog4j2.formatMsgNoLookups=true -Xms12G -Xmx12G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar forge.jar nogui

echo "Uploading File for the first time..."
rsync -av --progress /mnt/500GB/CC_Backup/crazycraft_onyx_"$(date +%F)".7z /home/minecraft/GDrive/Minecraft_Backups/


# main_file=$(stat -c %s /mnt/cyndaquil/rr-typhlosion_"$(date +%F)".7z)
# remote_file=$(stat -c %s /home/minecraft/GDrive/rr-typhlosion_"$(date +%F)".7z)

# main_file_second_check=$(stat -c %s /mnt/cyndaquil/rr-typhlosion_"$(date +%F)".7z)
# remote_file_second_check=$(stat -c %s /home/minecraft/GDrive/rr-typhlosion_"$(date +%F)".7z)

# if [[ "$main_file" -ne "$remote_file" ]]; then
#   echo "Files Sizes aren't the same, Trying again..."
#   rm /home/minecraft/GDrive/rr-typhlosion_"$(date +%F)".7z
#   sleep 5
#   sync
#   cp /home/minecraft/rr-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
#   sleep 10
#   if [[ "$main_file_second_check" -ne "$remote_file_second_check" ]]; then
#     echo "Files Sizes are STILL not the same, umounting and trying again."
#     sleep 100
#     fusermount -u /home/minecraft/GDrive
#     rclone mount --daemon GDrive:Minecraft_Backups/ /home/minecraft/GDrive/
#     sleep 10
#     ls /home/minecraft/GDrive/
#     rm /home/minecraft/GDrive/rr-typhlosion_"$(date +%F)".7z
#     sync
#     sleep 5
#     cp -v /mnt/cyndaquil/rr-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
#   fi
# else
#   echo "File Sizes Are Fine"
# fi

# md5_main_file=$(md5sum --tag /mnt/cyndaquil/rr-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)
# md5_remote_file=$(md5sum --tag /home/minecraft/GDrive/rr-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)

# md5_main_file_second_check=$(md5sum --tag /mnt/cyndaquil/rr-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)
# md5_remote_file_second_check=$(md5sum --tag /home/minecraft/GDrive/rr-typhlosion_"$(date +%F)".7z | cut -d '=' -f 2-)

# if [ "$md5_main_file" == "$md5_remote_file" ]; then
#   echo "File Hashes are fine."
# else
#     echo "Hashes aren't the same, trying again..."
#     rm /home/jesse/GDrive/rr-typhlosion_"$(date +%F)".7z
#     sleep 5
#     sync
#     cp -v /mnt/cyndaquil/rr-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
#     sleep 10
#   if [ "$md5_main_file_second_check" == "$md5_remote_file_second_check" ]; then
#     echo "File Hashes are fine"
#     else
#       echo "Hashes are STILL not the same, umounting and trying again..."
#       sleep 100
#       fusermount -u /home/minecraft/GDrive/
#       rclone mount --daemon GDrive:Minecraft_Backups/ /home/minecraft/GDrive/
#       rm /home/jesse/GDrive/Minecraft_Backups/rr-typhlosion_"$(date +%F)".7z
#       sync
#       sleep 5
#       cp -v /mnt/cyndaquil/rr-typhlosion_"$(date +%F)".7z /home/minecraft/GDrive/
#   fi
# fi

# # Start the Server backup
# cd /home/minecraft/ResonantRise/
# tmux new -d -s rr java -server -Xmx8196M -Xms8196M -XX:+UnlockExperimentalVMOptions -XX:ParallelGCThreads=16 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+AggressiveOpts -XX:+CMSIncrementalPacing -jar forge-1.12.2-14.23.5.2847-universal.jar nogui
#tmux new -d -s ftb java -Xms8096M -Xmx8096M -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -jar paper.jar --nogui
#cd /home/minecraft/skyworld/
#tmux new -d -s skyworld java -Xms2096M -Xmx2096M -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -jar serverjars-1.jar --nogui
#cd /home/minecraft/vanilla/
#tmux new -d -s vanilla java -Xms2096M -Xmx2096M -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -jar serverjars-1.jar --nogui
#sleep 60
#tmux send-keys -t ftb mv unload resource_nether C-m
#tmux send-keys -t ftb mvconfirm C-m
#rm -Rv /home/minecraft/ftb/resource_nether
#tmux send-keys -t ftb mv create resource_nether nether C-m
# tmux send-keys -t rr say\ Backup\ Is\ Complete C-m
echo "Done"
