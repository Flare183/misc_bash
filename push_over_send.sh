#!/bin/bash



load1m=$(uptime | awk '{ print $10 }' | cut -c1-4)
load10m=$(uptime | awk '{ print $11 }' | cut -c1-4)
load15m=$(uptime | awk '{ print $12 }' | cut -c1-4)
threshold1m="2.50"
threshold10m="3.00"
threshold15m="3.80"
result1m=$(echo "$load1m > $threshold1m" | bc)
result10m=$(echo "$load10m > $threshold10m" | bc)
result15m=$(echo "$load15m > $threshold15m" | bc)
email="youremail"
mailbody=$(mktemp)
send=0

if [ "$result15m" == 1 ]; then
  msg="Load 15 min: $load15m (threshold $threshold15m)"
  subject="ALERT: High load 15m ($load15m)"
  send=1
elif [ "$result10m" == 1 ]; then
  msg="Load 10 min: $load10m (threshold $threshold10m)"
  subject="ALERT: High load 10m ($load10m)"
  send=1
elif [ "$result1m" == 1 ]; then
  msg="Load 1 min: $load1m (threshold $threshold1m)"
  subject="ALERT: High load 1m ($load1m)"
  send=1
fi
