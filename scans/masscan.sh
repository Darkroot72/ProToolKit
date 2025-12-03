#!/usr/bin/env bash
# Masscan wrapper


masscan_run() {
log_header "Masscan (1-65535)"
check_cmd masscan || { log "${RED}masscan missing${RESET}"; return; }
[[ "$CONFIRM_AGGRESSIVE" != true ]] && { log "${YELLOW}Masscan blocked${RESET}"; return; }
local iface rate out="$TMPDIR/masscan.l"
iface=$(ip route show default 0.0.0.0/0 2>/dev/null | awk 'NR==1{print $5}') || iface="eth0"
read -rp "Rate (default ${DEFAULT_MASSCAN_RATE}): " rate
rate="${rate:-${DEFAULT_MASSCAN_RATE}}"
log "Using iface=$iface rate=$rate"
sudo masscan "$HOST" -p1-65535 --rate "$rate" --interface "$iface" -oL "$out" 2>&1 | tee -a "$LOG_FILE" || true
log "Masscan saved: $out"
}
