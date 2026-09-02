#!/usr/bin/env bash
#  _                                     _
# | |__   ___  _ __ ___   ___        ___| | ___  __ _ _ __   ___ _ __
# | '_ \ / _ \| '_ ` _ \ / _ \_____ / __| |/ _ \/ _` | '_ \ / _ \ '__|
# | | | | (_) | | | | | |  __/_____| (__| |  __/ (_| | | | |  __/ |
# |_| |_|\___/|_| |_| |_|\___|      \___|_|\___|\__,_|_| |_|\___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Remove Brave crash reports from home, where they do not belong.
find "$XDG_CONFIG_HOME/BraveSoftware/Brave-Browser/Crash Reports/completed" -name "*.dmp" -delete
find "$XDG_CONFIG_HOME/BraveSoftware/Brave-Browser/Crash Reports/completed" -name "*.meta" -delete

# Clean old Nextcloud config backups.
if [[ $(fd "nextcloud.cfg.backup" "$HOME/.config/Nextcloud" | wc -l) -gt 2 ]]; then
    while IFS= read -r old_file; do
        [[ -n "$old_file" ]] && rm -f -- "$old_file"
    done < <(
        diff \
            <(fd "nextcloud.cfg.backup" "$HOME/.config/Nextcloud") \
            <(fd "nextcloud.cfg.backup" "$HOME/.config/Nextcloud" | tail -n 2) \
            | sed -n 's/^< //p'
    )
fi
