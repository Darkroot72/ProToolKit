#!/usr/bin/env bash


ip_reputation() {
log_header "IP Reputation"
if [[ -z "${ABUSE_API_KEY:-}" ]]; then
log "${YELLOW}ABUSE_API_KEY not set. To enable: export ABUSE_API_KEY='your_key'${RESET}"
return
fi
check_cmd curl || { log "${RED}curl missing${RESET}"; return; }
local ip
ip=$(dig +short "$HOST" | head -n1)
ip="${ip:-$HOST}"
curl -sG "https://api.abuseipdb.com/api/v2/check" \
--data-urlencode "ipAddress=$ip" -H "Key: $ABUSE_API_KEY" -H "Accept: application/json" \
| (check_cmd jq && jq . || cat) | tee -a "$LOG_FILE" || true
}
