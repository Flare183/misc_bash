#!/usr/bin/env bash

# Bash Script to Auto Mount rclone shares


rclone mount --daemon Dropbox: /home/jesse/Dropbox/
rclone mount --daemon GDrive: /home/jesse/GDrive
