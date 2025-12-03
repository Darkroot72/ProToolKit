#!/usr/bin/env bash
# Nmap scans


nmap_fast() {
log_header "Nmap Fast Scan (top ${NMAP_FAST_PORTS})"
check_cmd nmap || { log "${RED}nmap missing${RESET}"; return; }
local base="$TMPDIR/nmap_fast"
nmap -T4 --top-ports "${NMAP_FAST_PORTS}" -sV -Pn -oA "$base" -- "$HOST" 2>&1 | tee -a "$LOG_FILE" || true
nmap_summary "$base"
}


nmap_os() {
log_header "Nmap OS Detection"
check_cmd nmap || { log "${RED}nmap missing${RESET}"; return; }
local base="$TMPDIR/nmap_os"
local cmd=(nmap -O -Pn -oA "$base" -- "$HOST")
if [[ "$ROOT_MODE" == false && -n "$(command -v sudo 2>/dev/null)" ]]; then cmd=(sudo "${cmd[@]}"); fi
"${cmd[@]}" 2>&1 | tee -a "$LOG_FILE" || true
nmap_summary "$base"
}


nmap_vuln() {
log_header "Nmap Vuln (NSE)"
check_cmd nmap || { log "${RED}nmap missing${RESET}"; return; }
[[ "$CONFIRM_AGGRESSIVE" != true ]] && { log "${YELLOW}nmap vuln blocked${RESET}"; return; }
local base="$TMPDIR/nmap_vuln"
nmap -sV --script vuln -T4 -Pn -oA "$base" -- "$HOST" 2>&1 | tee -a "$LOG_FILE" || true
nmap_summary "$base"
}


udp_scan() {
log_header "Nmap UDP Top 30"
[[ "$CONFIRM_AGGRESSIVE" != true ]] && { log "${YELLOW}UDP scan blocked${RESET}"; return; }
check_cmd nmap || { log "${RED}nmap missing${RESET}"; return; }
local base="$TMPDIR/nmap_udp"
nmap -sU --top-ports 30 -T4 --max-retries 1 --host-timeout 30s -oA "$base" -- "$HOST" 2>&1 | tee -a "$LOG_FILE" || true
nmap_summary "$base"
}


nmap_summary() {
local base="$1"
if [[ -f "${base}.gnmap" ]]; then
log_header "Nmap summary"
grep -E "Ports:|open" "${base}.gnmap" | sed -n '1,80p' | tee -a "$LOG_FILE"
awk -F'Ports: ' '/Ports:/ {print $2}' "${base}.gnmap" | sed 's/, /\n/g' | sed -n '1,10p' | awk -F'/' '{print $1" " $3" "$4}' | tee -a "$LOG_FILE"
else
log "No gnmap output to summarize for $base"
fi
}
