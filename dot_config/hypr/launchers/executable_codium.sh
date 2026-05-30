#!/usr/bin/env bash
VSCODE_PORTABLE="$XDG_DATA_HOME/VSCodium" VSCODE_CLI_DATA_DIR="$XDG_DATA_HOME/VSCodium/cli" exec /usr/bin/codium "$@"
