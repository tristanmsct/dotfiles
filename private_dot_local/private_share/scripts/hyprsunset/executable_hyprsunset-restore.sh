#!/usr/bin/env bash
#  _                                               _                      _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      _ __ ___  ___| |_ ___  _ __ ___
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____| '__/ _ \/ __| __/ _ \| '__/ _ \
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| | |  __/\__ \ || (_) | | |  __/
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|    |_|  \___||___/\__\___/|_|  \___|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Restores previous Hyprsunset configuration.
# -----------------------------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1091

HYPRSUNSET_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
script_name=$(basename "$0")

source "$HYPRSUNSET_DIR/hyprsunset-utils.sh"

logger -t hyprsunset -p user.info "[$script_name] Restoring Hyprsunset configuration"

hyprsunset_ensure_running
hyprsunset_restore "$script_name"

hyprsunset_refresh_waybar
