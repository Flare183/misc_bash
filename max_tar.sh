#!/bin/bash

# Max Tar Script
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]

# Reference: tar cvf srbcserver_"$(date +%F)".tar main_sys_backup/
#            xz -z -9 -T 4 srbcserver_"$(date +%F)".tar

# Key Note: We can just use an enviroment var for compression

# New Command Reference: XZ_OPT=-9 tar cJf tarfile.tar.xz directory/

echo "Usage: max_tar.sh <archive_name.tar.xz> <directory>"
XZ_OPT=-z9T4 tar cJvf "$1" "$2"

