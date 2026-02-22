#!/usr/bin/env bash

if [ -f "$HOME/.config/Nextcloud/Nextcloud_sync.log" ]; then
    echo '{"class": "state_ko"}'
else
    echo '{"class": "state_ok"}'
fi
