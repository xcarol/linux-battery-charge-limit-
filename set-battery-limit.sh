#!/bin/bash
# Set battery charge limit
LIMIT=80
BATTERY=$(ls /sys/class/power_supply/ | grep BAT | head -n 1)

if [ -n "$BATTERY" ]; then
    echo "$LIMIT" | sudo tee /sys/class/power_supply/$BATTERY/charge_control_end_threshold > /dev/null
    echo "Battery charge limit set to ${LIMIT}% for $BATTERY"
else
    echo "No battery detected."
    exit 1
fi
