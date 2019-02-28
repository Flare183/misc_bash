#!/usr/bin/env bash
# Minecraft Backup Script
# Written by Jesse N. Richardson (negativeflare@negativeflare.xyz) [negativeflare]

tmux send-keys -t Minecraft save-all C-m
sync
cp -Rv papernut papernut_"$(date +%F)"
7zip ~/Backups/papernut_"$(date +%F)".7z ~/papernut_"$(date +%F)"
rm -Rv ~/papernut_"$(date +%F)"
