#!/bin/bash

# Start Script for Moonstone
# Written by Jesse N. Richardson [negativeflare] (flare183@charter.net)

echo "Hello! This is the start script for Moonstone"
echo "This script will ask you for the sudo password sometimes, so just bear with it"
sleep 10

echo "Starting monero daemon...."
sudo service monero start
sleep 20

echo "Starting Redis..."
tmux new -s redis -c /home/jesse/redis-server/src/redis-server
sleep 10

echo "Starting RPC Wallet..."
tmux new -s wallet -c monero-wallet-rpc --wallet-file /home/jesse/Wallet --password hyperionforgod417 --rpc-bind-port 8082 --disable-rpc-login

wait 20
echo "Now Starting Pool..."
tmux new -s pool -c /home/jesse/.nvm/v0.10.25/bin/node /home/jesse/forknote-pool/init.js

