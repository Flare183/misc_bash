#!/usr/bin/env bash
# Minecraft Backup Script
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]




echo "This is a Minecraft Backup Script, it looks for the Minecraft tmux session"
echo "Then it looks for the 'CrazyCraft' folder, and backs it up"
echo "Then 7zips it up and puts it in the backups folder"
echo "This Script backs up the Typhlosion Server to Google Drive as well"

echo "NOTE: For this script to run properly you need the 7zip script in my misc_bash repo on Github"
echo "https://github.com/Flare183/misc_bash"

sleep 5

echo "Setting up new log file"
touch /var/log/minecraft_backup/minecraft_backup.log
date -R >> /var/log/minecraft_backup/minecraft_backup.log


#tmux send-keys -t vanilla say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 5 C-m
#tmux send-keys -t lobby say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 5 C-m
tmux send-keys -t crazycraft say\ SERVER\ GOING\ DOWN\ FOR\ BACKUPS\ C-m
tmux send-keys -t crazycraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 5 C-m
sleep 60

#tmux send-keys -t vanilla say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 4 C-m
#tmux send-keys -t skyworld say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 4 C-m
tmux send-keys -t crazycraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 4 C-m
sleep 60

#tmux send-keys -t vanilla say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 3 C-m
#tmux send-keys -t skyworld say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 3 C-m
tmux send-keys -t crazycraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 3 C-m
sleep 60

#tmux send-keys -t vanilla say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 2 C-m
#tmux send-keys -t skyworld say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 2 C-m
tmux send-keys -t crazycraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 2 C-m
sleep 60

#tmux send-keys -t vanilla say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 1 C-m
#tmux send-keys -t skyworld say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 1 C-m
tmux send-keys -t crazycraft say\ WARNING:\ SHUTTING\ DOWN\ SERVER\ IN\ 1 C-m
sleep 60


#tmux send-keys -t vanilla save-all C-m
#tmux send-keys -t skyworld save-all C-m
tmux send-keys -t crazycraft save-all C-m
sleep 10

#tmux send-keys -t vanilla stop C-m
#tmux send-keys -t skyworld stop C-m
tmux send-keys -t crazycraft stop C-m
sleep 60
sync

mkdir /mnt/cyndaquil/Minecraft_Compress/crazycraft-typhlosion_"$(date +%F)"/
rsync -av --progress --max-size=10G /mnt/mudkip/crazycraft /mnt/cyndaquil/Minecraft_Compress/crazycraft-typhlosion_"$(date +%F)"/
#cp -Rv /home/minecraft/waterfall/ /mnt/cyndaquil/Minecraft_Compress/ftb-typhlosion_"$(date +%F)"/
#cp -Rv /home/minecraft/skyworld/ /mnt/cyndaquil/Minecraft_Compress/ftb-typhlosion_"$(date +%F)"/
#cp -Rv /home/minecraft/lobby/ /mnt/cyndaquil/Minecraft_Compress/ftb-typhlosion_"$(date +%F)"/
#cp -Rv /home/minecraft/vanilla/ /mnt/cyndaquil/Minecraft_Compress/ftb-typhlosion_"$(date +%F)"/
sync
sleep 10

echo "Running 7zip compress command"
/usr/local/bin/7zip /mnt/cyndaquil/CC_Backup/crazycraft-typhlosion_"$(date +%F)".7z /mnt/cyndaquil/Minecraft_Compress/crazycraft-typhlosion_"$(date +%F)"
rm -Rv /mnt/cyndaquil/Minecraft_Compress/crazycraft-typhlosion_"$(date +%F)"
sync
sleep 20


# Start the Server backup
cd /mnt/mudkip/crazycraft/
#tmux new -d -s crazycraft /usr/lib/jvm/java-8-openjdk-amd64/bin/java -Dlog4j2.formatMsgNoLookups=true -Xms12G -Xmx12G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar forge.jar nogui
tmux new -d -s crazycraft /usr/lib/jvm/java-8-openjdk-amd64/bin/java -Xms16G -Xmx16G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=20 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=32 -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Dsun.rmi.dgc.server.gcInterval=600000 -Daikars.new.flags=true -Dlog4j2.formatMsgNoLookups=true -jar forge.jar nogui
# Copy backup to iolite for later uploading.
rsync -av --progress /mnt/cyndaquil/CC_Backup/crazycraft-typhlosion_"$(date +%F)".7z jesse@iolite:/mnt/Backup/Minecraft/CC_Backup/
echo "Done"
