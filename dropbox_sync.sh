#!/bin/bash


# Rsync Script to Sync Dropbox Files from and to the Desktop

# This Version is made to work on the Pearl test server
# For now....


# From Desktop to Pearl Test server:

# rsync -rtuhp --progress /mnt/WDBlue1TB/Rsync_Work/ jesse@pearl:~/Dropbox/

# From Pearl Test Server to Desktop:

#rsync -rtuhp --delete-after --progress jesse@pearl:~/Dropbox/ /mnt/WDBlue1TB/Rsync_Work
