#!/bin/bash
# Forge Player Data Backup
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]

# This needs to run every 3 hours
# This copies all player data over to Minecraft_Compress and Compresses it and throw it into CC_Backup just like the other script

echo "Backing up Player Data"
echo "Informing players of Player Data Backup"
#tmux send-keys -t crazycraft say\ Saving\ Player\ Data C-m
#tmux send-keys -t crazycraft say\ Hold\ On\ To\ Your\ Butts C-m
tmux send-key -t crazycraft say\ Testing\ Player\ Backup\ Script C-m
tmux send-keys -t crazycraft save-all C-m
sleep 10
sync

# First Copy it
rsync -av --progress /mnt/mudkip/crazycraft/world/playerdata /mnt/cyndaquil/Minecraft_Compress/playerdata-$(date +"%T" | sed 's/:/_/g')
sync

# Then Compress it
tar cvzf /mnt/cyndaquil/CC_Backup/playerdata/playerdata-$(date +"%T" | sed 's/:/_/g').tar.gz /mnt/cyndaquil/Minecraft_Compress/playerdata-$(date +"%T" | sed 's/:/_/g')
sleep 10
sync

# Now clean up
rm -Rvf /mnt/cyndaquil/Minecraft_Compress/playerdata-$(date +"%T" | sed 's/:/_/g')
