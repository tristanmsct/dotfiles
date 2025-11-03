#!/usr/bin/env bash
#           _                         _        _
#  ___  ___| |_ _   _ _ __        ___| |_ __ _| |_ ___
# / __|/ _ \ __| | | | '_ \ _____/ __| __/ _` | __/ _ \
# \__ \  __/ |_| |_| | |_) |_____\__ \ || (_| | ||  __/
# |___/\___|\__|\__,_| .__/      |___/\__\__,_|\__\___|
#                    |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

if [[ ! -f ~/.local/state/desktop/state.json ]]; then
cat > $HOME/.local/state/desktop/state.json << 'EOF'
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
  }
}
EOF
fi

if [[ ! -f ~/.local/state/desktop/battery.json ]]; then
cat > $HOME/.local/state/desktop/battery.json << 'EOF'
{
  "battery_level": 100
}
EOF
fi
