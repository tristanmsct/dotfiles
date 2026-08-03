#!/usr/bin/env bash
#                             _                   _                     _ _       _
#   ___ __ ___   ____ _      (_)_ __  _ __  _   _| |_      _____      _(_) |_ ___| |__   ___ _ __
#  / __/ _` \ \ / / _` |_____| | '_ \| '_ \| | | | __|____/ __\ \ /\ / / | __/ __| '_ \ / _ \ '__|
# | (_| (_| |\ V / (_| |_____| | | | | |_) | |_| | ||_____\__ \\ V  V /| | || (__| | | |  __/ |
#  \___\__,_| \_/ \__,_|     |_|_| |_| .__/ \__,_|\__|    |___/ \_/\_/ |_|\__\___|_| |_|\___|_|
#                                    |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

CAVA_CONFIG="$HOME/.config/cava/config"
CAVA_CONFIG_MINI="$HOME/.config/cava/config_mini"


if grep -qxF "method = pulse" $CAVA_CONFIG; then
    sed -i -E "s/^(method = pulse)$/; \1/" $CAVA_CONFIG
    sed -i -E "s/^(source = alsa_input)/; \1/" $CAVA_CONFIG
    sed -i -E "s/^(method = pulse)$/; \1/" $CAVA_CONFIG_MINI
    sed -i -E "s/^(source = alsa_input)/; \1/" $CAVA_CONFIG_MINI
else
    sed -i -E "s/^; (method = pulse)$/\1/" $CAVA_CONFIG
    sed -i -E "s/^; (source = alsa_input)/\1/" $CAVA_CONFIG
    sed -i -E "s/^; (method = pulse)$/\1/" $CAVA_CONFIG_MINI
    sed -i -E "s/^; (source = alsa_input)/\1/" $CAVA_CONFIG_MINI
fi

pkill -SIGUSR1 cava
