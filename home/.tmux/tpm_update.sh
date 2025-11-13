#!/bin/bash
# Checks date and runs TPM update, piping output to 'tmux display-popup'

UPDATE_FILE=~/.tmux/plugins/.last_update
TIME_LIMIT=604800 # 7 days in seconds

if [[ ! -f "$UPDATE_FILE" || "$(($(date +%s) - $(stat -c %Y "$UPDATE_FILE" 2>/dev/null)))" -gt "$TIME_LIMIT" ]]; then
    # Print status message
    echo "[tmux] Running TPM auto-update... (Check log window for results)"
    ~/.tmux/plugins/tpm/bin/update_plugins all && touch "$UPDATE_FILE"
    echo "[tmux] TPM update complete."
else
    echo "[tmux] Skipping TPM auto-update (recently updated)."
fi
