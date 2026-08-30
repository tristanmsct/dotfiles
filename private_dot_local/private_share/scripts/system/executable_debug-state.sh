#!/usr/bin/env bash

if [ -d "$HOME/.pki" ]; then
    echo '{"class": "state_ko"}'
else
    echo '{"class": "state_ok"}'
fi
