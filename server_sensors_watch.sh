#!/bin/bash
while true
do


temp=$(sensors -u | grep -m 1 temp1_input)
# load10m=$(uptime | awk '{ print $11 }' | cut -c1-4)
# load15m=$(uptime | awk '{ print $12 }' | cut -c1-4)
# threshold1m="1.00"
# threshold10m="3.00"
# threshold15m="3.80"
# result1m=$(echo "$load1m > $threshold1m" | bc)
# result10m=$(echo "$load10m > $threshold10m" | bc)
# result15m=$(echo "$load15m > $threshold15m" | bc)

if [ "$temp" == 50 ]; then
  pushover -t "Quartz: LoadAvg Warning" Quartz: LoadAvg 1m: '$result1m'
elif [ "$result10m" == 1 ]; then
  msg="Load 10 min: $load10m (threshold $threshold10m)"
  subject="ALERT: High load 10m ($load10m)"
  send=1
elif [ "$result15m" == 1 ]; then
  msg="Load 1 min: $load1m (threshold $threshold1m)"
  subject="ALERT: High load 1m ($load1m)"
  send=1
fi
done


