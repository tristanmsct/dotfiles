#!/usr/bin/env bash
#                      _             _   _
#   ___ _ __ ___  __ _| |_ ___      | |_| |__   ___ _ __ ___   ___
#  / __| '__/ _ \/ _` | __/ _ \_____| __| '_ \ / _ \ '_ ` _ \ / _ \
# | (__| | |  __/ (_| | ||  __/_____| |_| | | |  __/ | | | | |  __/
#  \___|_|  \___|\__,_|\__\___|      \__|_| |_|\___|_| |_| |_|\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

wallpaper=$1

wal -q -i $wallpaper

# If theme is too dark, we generate a more saturated one.

# Read colors 2, 3, 4, and 5 (skipping the first one)
colors=($(sed -n '2,5p' $HOME/.cache/wal/colors))

# Function to check if a color is dark (brightness < 50%)
is_dark() {
    local color=$1
    # Convert hex to RGB
    r=$((16#${color:1:2}))
    g=$((16#${color:3:2}))
    b=$((16#${color:5:2}))

    # Calculate brightness (Perceived brightness formula)
    brightness=$(( (r * 299 + g * 587 + b * 114) / 1000 ))

    # Return 0 (true) if brightness is low, otherwise 1 (false)
    [[ $brightness -lt 120 ]]
}

# Count how many of the first 3 colors are dark
dark_count=0
for color in "${colors[@]}"; do
    is_dark "$color" && ((dark_count++))
done

# If at least 3 out of 4 colors are dark, rerun with --saturate 0.6
if [[ $dark_count -ge 3 ]]; then
    wal -q -i "$wallpaper" --saturate 0.6
fi
