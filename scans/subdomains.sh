#!/usr/bin/env bash


subdomain_scan() {
log_header "Passive subdomain enumeration (crt.sh)"
if ! (check_cmd curl && check_cmd jq); then log "${YELLOW}curl/jq required${RESET}"; return; fi
curl -s "https://crt.sh/?q=%25.$HOST&output=json" 2>/dev/null | jq -r '.[].name_value' 2>/dev/null \
| sed 's/\*\.//g' | sort -u | tee -a "$LOG_FILE" || true
}
