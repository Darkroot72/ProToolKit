#!/usr/bin/env bash
}


cleanup() {
log "Cleanup completed."
[[ -d "$TMPDIR" ]] && rm -rf "$TMPDIR"
}
trap cleanup EXIT
trap 'log "Interrupted by user."; exit 130' INT


validate_host() {
local h="$1"
[[ -z "$h" ]] && return 1
if [[ "$h" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
IFS='.' read -ra oct <<<"$h"
for o in "${oct[@]}"; do (( o>=0 && o<=255 )) || return 1; done
return 0
fi
if [[ "$h" =~ : ]]; then [[ "$h" =~ ^[0-9a-fA-F:.%]+$ ]] && return 0 || return 1; fi
[[ "$h" =~ ^([a-zA-Z0-9][-a-zA-Z0-9]{0,62}\.)+[a-zA-Z]{2,}$ ]] && return 0
return 1
}


prompt_host_interactive() {
if check_cmd fzf && [[ -f "$HISTORY_FILE" ]]; then
log "Press ENTER to type a host or select recent from history (fzf)."
read -rp "Press ENTER to continue..."
if [[ -s "$HISTORY_FILE" ]]; then
local selection
selection=$(tac "$HISTORY_FILE" | sed 's/^[^ ]* //' | uniq | fzf --height=10 --prompt="Select recent host or type new: " --cycle) || true
if [[ -n "$selection" ]]; then
HOST="$selection"
printf "Selected host: %s\n" "$HOST"
fi
fi
fi


while [[ -z "$HOST" ]]; do
read -rp "Target Host/IP/Domain: " HOST
HOST="${HOST//[[:space:]]/}"
if ! validate_host "$HOST"; then
log "${RED}Invalid host: $HOST${RESET}"
HOST=""
fi
done
mkdir -p "$(dirname "$HISTORY_FILE")"
printf "%s %s\n" "$(date '+%F %T')" "$HOST" >> "$HISTORY_FILE"
tail -n 200 "$HISTORY_FILE" > "${HISTORY_FILE}.tmp" && mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE" || true
}


toggle_aggressive() {
if [[ "$CONFIRM_AGGRESSIVE" == true ]]; then
CONFIRM_AGGRESSIVE=false
log "Aggressive mode DISABLED"
else
read -rp "Confirm aggressive actions (type YES): " a
if [[ "${a^^}" == "YES" ]]; then
CONFIRM_AGGRESSIVE=true
log "Aggressive mode ENABLED"
else
log "Aggressive mode remains disabled"
fi
fi
}
