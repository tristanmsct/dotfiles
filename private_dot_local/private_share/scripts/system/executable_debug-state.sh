#!/usr/bin/env bash

if [ ! -f "$DESKTOP_STATE_DIR/state.json" ]; then
    echo '{"class": "state_ko"}'
else
    echo '{"class": "state_ok"}'
fi
