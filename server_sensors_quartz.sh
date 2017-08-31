#!/bin/bash
# Reference: sensors | grep "^temp1" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//'
while true
do


temp_core1=$(sensors | grep "^temp1" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//' && sleep 120)
temp_core2=$(sensors | grep "^temp2" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//' && sleep 120)
peak_temp="50"

if [[ "$temp_core1" > "$peak_temp" || "$temp_core1" == "$peak_temp" ]]; then
    pushover -t "Quartz Heat Sensors" Core 1 Is Over 45C!
elif [[ "$temp_core2" > "$peak_temp" || "$temp_core2" == "$peak_temp" ]]; then
    pushover -t "Quartz Heat Sensors" Core 2 Is Over 45C!
fi
done



