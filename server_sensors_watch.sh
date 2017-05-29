#!/bin/bash
# Reference: sensors | grep "^temp1" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//'
while true
do


temp_core1=$(sensors | grep "^temp1" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//' && sleep 120)
temp_core2=$(sensors | grep "^temp2" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//' && sleep 120)
peak_temp="40"
# load10m=$(uptime | awk '{ print $11 }' | cut -c1-4)
# load15m=$(uptime | awk '{ print $12 }' | cut -c1-4)
# threshold1m="1.00"
# threshold10m="3.00"
# threshold15m="3.80"
# result1m=$(echo "$load1m > $threshold1m" | bc)
# result10m=$(echo "$load10m > $threshold10m" | bc)
# result15m=$(echo "$load15m > $threshold15m" | bc)

if [[ "$temp_core1" > "$peak_temp" || "temp_core1" == "$peak_temp" ]]; then
    pushover -t "Ruby Heat Sensors" Core 1 Is Over 40C!
elif [[ "$temp_core2" > "$peak_temp" || "temp_core2" == "$peak_temp" ]]; then
    pushover -t "Ruby Heat Sensors" Core 2 Is Over 40C!
# elif [ "$result15m" == 1 ]; then
#   msg="Load 1 min: $load1m (threshold $threshold1m)"
#   subject="ALERT: High load 1m ($load1m)"
#   send=1
fi
done



