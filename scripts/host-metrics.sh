#!/bin/bash

throttled=$(vcgencmd get_throttled | sed 's/throttled=//g')
temp=$(vcgencmd measure_temp | sed 's/temp=//g' | sed "s/'C//g")
load=$(uptime | sed 's/^.*load average: //g' | sed 's/\s//g')
dbm=$(/usr/sbin/iwconfig wlan0 | grep Signal | /usr/bin/awk '{print $4}' | /usr/bin/cut -d'=' -f2)

mosquitto_pub -h localhost -p 1883 -t "tele/host/$(hostname)" -m "{\"host\":\"$(hostname)\",\"time\":$(date +%s),\"throttled\":\"$throttled\",\"temp\":$temp,\"load\":[$load],\"dbm\":\"$dbm\"}"
