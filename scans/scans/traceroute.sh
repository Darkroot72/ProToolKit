#!/usr/bin/env bash


traceroute_moderno() {
log_header "Traceroute"
if check_cmd mtr; then sudo mtr --report --report-cycles=3 "$HOST" 2>&1 | tee -a "$LOG_FILE" || true
elif check_cmd traceroute; then traceroute -n "$HOST" 2>&1 | tee -a "$LOG_FILE" || true
else log "${YELLOW}mtr/traceroute missing${RESET}"; fi
}
