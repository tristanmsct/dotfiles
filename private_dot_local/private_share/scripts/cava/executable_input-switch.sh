#!/usr/bin/env bash
#                         _                   _                     _ _       _
#   ___ __ ___   ____ _  (_)_ __  _ __  _   _| |_      _____      _(_) |_ ___| |__
#  / __/ _` \ \ / / _` | | | '_ \| '_ \| | | | __|____/ __\ \ /\ / / | __/ __| '_ \
# | (_| (_| |\ V / (_| | | | | | | |_) | |_| | ||_____\__ \\ V  V /| | || (__| | | |
#  \___\__,_| \_/ \__,_| |_|_| |_| .__/ \__,_|\__|    |___/ \_/\_/ |_|\__\___|_| |_|
#                                |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

CAVA_CONFIG="$XDG_CONFIG_HOME/cava/config"
CAVA_CONFIG_MINI="$XDG_CONFIG_HOME/cava/config_mini"
TURBO_CAVA_CONFIG="$XDG_CONFIG_HOME/quickshell/turbo-cava.qml"


if grep -qxF "method = pulse" "$CAVA_CONFIG"; then
    sed -i -E "s/^(method = pulse)$/; \1/" "$CAVA_CONFIG"
    sed -i -E "s/^(source = alsa_input)/; \1/" "$CAVA_CONFIG"
    sed -i -E "s/^(method = pulse)$/; \1/" "$CAVA_CONFIG_MINI"
    sed -i -E "s/^(source = alsa_input)/; \1/" "$CAVA_CONFIG_MINI"

    sed -i -E "s/^(source = alsa_input)/; \1/" "$TURBO_CAVA_CONFIG"
    touch "$TURBO_CAVA_CONFIG"
else
    sed -i -E "s/^; (method = pulse)$/\1/" "$CAVA_CONFIG"
    sed -i -E "s/^; (source = alsa_input)/\1/" "$CAVA_CONFIG"
    sed -i -E "s/^; (method = pulse)$/\1/" "$CAVA_CONFIG_MINI"
    sed -i -E "s/^; (source = alsa_input)/\1/" "$CAVA_CONFIG_MINI"

    sed -i -E "s/^; (source = alsa_input)/\1/" "$TURBO_CAVA_CONFIG"
    touch "$TURBO_CAVA_CONFIG"
fi

pkill -SIGUSR1 cava
