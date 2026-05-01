#!/usr/bin/env bash
#           _                         _        _
#  ___  ___| |_ _   _ _ __        ___| |_ __ _| |_ ___
# / __|/ _ \ __| | | | '_ \ _____/ __| __/ _` | __/ _ \
# \__ \  __/ |_| |_| | |_) |_____\__ \ || (_| | ||  __/
# |___/\___|\__|\__,_| .__/      |___/\__\__,_|\__\___|
#                    |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

STATE_FILE="$HOME/.local/state/desktop/state.json"
BATTERY_FILE="$HOME/.local/state/desktop/battery.json"

if [ ! -e "$STATE_FILE" ] || [ ! -s "$STATE_FILE" ]; then
cat > $STATE_FILE << 'EOF'
{
  "theme": {
    "accent_color": {
      "enabled": false
    },
      "mode": "dark",
      "saturation": {
      "enabled": false
    }
  },
  "display": {
    "monitor_external_only": false
  },
  "waybar": {
    "enabled": true
  },
  "vpn": {
    "connected": false
  },
  "hyprsunset": {
    "auto_timer": true,
    "temperature": 6500,
    "filter_on": false
  },
  "focusmode": {
    "enabled": false
  }
}
EOF
fi

if [ ! -e "$BATTERY_FILE" ] || [ ! -s "$BATTERY_FILE" ]; then
cat > $BATTERY_FILE << 'EOF'
{
  "battery_level": 100
}
EOF
fi
