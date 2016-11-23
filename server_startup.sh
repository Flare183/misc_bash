#!/bin/bash

# Server Startup Script
# Written by Jesse N. Richardson (Flare183, negativeflare) [flare183@nctv.com]

# Wrote because I got lazy and didn't want to run 100+ Programs when I start up my server
# And because I didn't want to write some dumb service files for it either

# Filename: server_startup.sh

# Clearing the screen
clear
cd ~
# Running ZNC first
echo "Running ZNC..."
sleep 2
znc
cd ~
cd minecraft
echo "Starting Minecraft..."
sleep 2
./start.sh
cd ~
cd /usr/local/games
echo "Starting Tremulous Server"
screen /tremded-gpp.x86 +set g_humanBuildPoints 150 +set alienBuildPoints 150 +set dedicated 1 +exec server.cfg &
cd ~
cd ts3server/teamspeak3-server_linux_x86
./ts3server_startscript.sh start
echo "Going to run cups-browsed, this will ask for your sudo password..."
sleep 5
sudo cups-browsed
echo "Done"
