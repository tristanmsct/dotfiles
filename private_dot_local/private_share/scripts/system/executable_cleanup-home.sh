#!/usr/bin/env bash
#       _                                    _
#   ___| | ___  __ _ _ __  _   _ _ __       | |__   ___  _ __ ___   ___
#  / __| |/ _ \/ _` | '_ \| | | | '_ \ _____| '_ \ / _ \| '_ ` _ \ / _ \
# | (__| |  __/ (_| | | | | |_| | |_) |_____| | | | (_) | | | | | |  __/
#  \___|_|\___|\__,_|_| |_|\__,_| .__/      |_| |_|\___/|_| |_| |_|\___|
#                               |_|
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

# Clean up after Boosteroid.
rm -f "$XDG_DATA_HOME/Boosteroid.svg"
rm -f "$XDG_DATA_HOME/applications/discord-1170028348756471908.desktop"
sed -i -E "s|/home/tristan/.local/share/Boosteroid.svg|Boosteroid|" "$XDG_DATA_HOME/applications/Boosteroid.desktop"
