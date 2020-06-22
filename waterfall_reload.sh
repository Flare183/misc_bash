#!/bin/bash
# Waterfall reload Script
# Written by Jesse N. Richardson (jr.fire.flare@gmail.com) [negativeflare]


tmux send-keys -t waterfall C-c
rm /home/minecraft/waterfall/plugins/TAB_performance_test.jar
tmux send-keys -t waterfall java -jar serverjars-1.jar C-m
