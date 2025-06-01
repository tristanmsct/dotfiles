#!/usr/bin/env bash
new_val=$1

# Cap the value at 10
[ $new_val -lt 20 ] && new_val=20

# Store the actual value in a temp file
# echo $new_val > /tmp/eww_brightness

brightnessctl set $(($(brightnessctl max) * $new_val / 100))

# Apply the brightness change (replace with your actual brightness command)
# brightnessctl set ${new_val}%
