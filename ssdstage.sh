# SSD Staging Script for iolite
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]

# First off Check to see if there is data on SSD
backups=$(ls -A /mnt/SSD/Staging/Backups)


if [ "$backups" ]; then
  cp -Rv /mnt/SSD/Staging/Backups/* /mnt/Backups/
else
  echo "Directory is empty, quitting the backups part"
fi
