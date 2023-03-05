#!/bin/bash
# Forge Player and World Data Backup Daily Backup Script
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]

# This needs to run every ~2 hours
# This copies all Player and World Data over to Minecraft_Compress and Compresses it and throw it into CC_Backup just like the other script

# Main Vars
timestamp=$(date +"%T %F" | sed 's/:/-/g' | sed 's/ /_/g')

echo "Backing up Player And World Data"
echo "Informing Players"
tmux send-keys -t crazycraft say\ Backing\ Up\ World\ and\ Player\ Data C-m
tmux send-keys -t crazycraft say\ Hold\ On\ To\ Your\ Butts C-m
sleep 2
tmux send-keys -t crazycraft save-all C-m
sleep 10
sync

# First Copy it
# No point in using the player data alone
#rsync -av --progress /mnt/mudkip/crazycraft/world/playerdata /mnt/cyndaquil/Minecraft_Compress/playerdata-$timestamp
rsync -av --progress /mnt/mudkip/crazycraft/world /mnt/cyndaquil/Minecraft_Compress/worlddata-"$timestamp"
sync

# Then Compress it
#tar cvzf /mnt/cyndaquil/CC_Backup/playerdata/playerdata-$timestamp.tar.gz /mnt/cyndaquil/Minecraft_Compress/playerdata-$timestamp
tar cvf - /mnt/cyndaquil/Minecraft_Compress/worlddata-"$timestamp" | pigz -p 6 > /mnt/cyndaquil/CC_Backup/worlddata/worlddata-"$timestamp".tar.gz
sleep 10
sync

# Let's copy it to iolite
rsync -av /mnt/cyndaquil/CC_Backup/worlddata/worlddata-"$timestamp".tar.gz jesse@iolite:/mnt/2TB/Minecraft/CC_Backup/worlddata-"$timestamp".tar.gz

# Now clean up
echo "Cleaning up"
rm -Rvf /mnt/cyndaquil/Minecraft_Compress/*
