#!/usr/bin/env bash
# DNS, HTTP and SSL functions


dns_info() {
log_header "DNS & WHOIS"
if check_cmd dig; then dig +noall +answer "$HOST" ANY 2>/dev/null | tee -a "$LOG_FILE" || true; else log "${YELLOW}dig missing${RESET}"; fi
if check_cmd whois; then whois "$HOST" 2>/dev/null | tee -a "$LOG_FILE" || true; else log "${YELLOW}whois missing${RESET}"; fi
}


http_fingerprint() {
log_header "HTTP Fingerprint & Security Headers"
check_cmd curl || { log "${RED}curl missing${RESET}"; return; }
local proto="http" headers="$TMPDIR/headers.txt"
if curl -sI --max-time 3 "https://$HOST" >/dev/null 2>&1; then proto="https"; fi
curl -sI --max-time 6 "$proto://$HOST" | tee "$headers" | tee -a "$LOG_FILE" || true
local h; h=$(tr '[:upper:]' '[:lower:]' < "$headers")
grep -qi "server:" <<<"$h" && log "Server header: $(grep -i '^server:' "$headers" | head -n1)"
grep -qi "strict-transport-security" <<<"$h" || log "${YELLOW}Missing HSTS${RESET}"
grep -qi "x-frame-options" <<<"$h" || log "${YELLOW}Missing X-Frame-Options${RESET}"
grep -qi "content-security-policy" <<<"$h" || log "${YELLOW}Missing CSP${RESET}"
}


ssl_scan() {
log_header "SSL/TLS scan"
check_cmd openssl || { log "${RED}openssl missing${RESET}"; return; }
if ! nc -z -w2 "$HOST" 443 &>/dev/null; then log "${YELLOW}443 closed (skipping SSL scan)${RESET}"; return; fi
{ echo | openssl s_client -connect "${HOST}:443" -servername "$HOST" 2>/dev/null; } \
| openssl x509 -noout -dates -issuer -subject -fingerprint 2>/dev/null | tee -a "$LOG_FILE" || true
}
