#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Load config & utils
source ./config.sh
source ./utils.sh

# Load scans & exports
for f in scans/*.sh; do source "$f"; done
for f in export/*.sh; do source "$f"; done

main() {
  detect_root
  warn_if_missing nmap masscan dig whois curl jq nc openssl mtr traceroute fzf || true
  prompt_host_interactive

  log_header "Initial Reachability"
  if ping -c1 -W2 "$HOST" &>/dev/null; then log "${GREEN}ICMP reachable${RESET}"; else log "${YELLOW}ICMP may be filtered${RESET}"; fi

  while true; do
    show_menu
    printf "\nPress ENTER to continue..."
    read -r _
  done
}

main
