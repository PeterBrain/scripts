#!/usr/bin/env bash

TEMP_FILE="/sys/class/thermal/thermal_zone0/temp"

ORIGINAL_TEMP=$(cat $TEMP_FILE 2>/dev/null)
TEMP_C=$((ORIGINAL_TEMP/1000))
TEMP_F=$(($TEMP_C * 9/5 + 32))

echo $TEMP_C °C
echo $TEMP_F °F
