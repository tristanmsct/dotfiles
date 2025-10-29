#!/usr/bin/env bash

if [ ! -s "$HOME/.local/state/desktop/state.json" ]; then
    echo '{"class": "state_ko"}'
else
    echo '{"class": "state_ok"}'
fi
