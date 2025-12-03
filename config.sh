#!/usr/bin/env bash
# =========================================================
# Configuración global de PRO TOOLKIT
# =========================================================

readonly VERSION="V11.1-FULL"
readonly START_TS="$(date +%Y%m%d_%H%M%S)"
readonly LOG_FILE="ProToolkit_${START_TS}.log"
TMPDIR="$(mktemp -d /tmp/protoolkit_${START_TS}.XXXXXX)"
HOST=""
ROOT_MODE=false
CONFIRM_AGGRESSIVE=false
ABUSE_API_KEY="${ABUSE_API_KEY:-}"  # Optional

# Colores para CLI
RED=$'\e[31m'; GREEN=$'\e[32m'; YELLOW=$'\e[33m'; CYAN=$'\e[36m'; RESET=$'\e[0m'

# Trap para limpieza
cleanup() {
    [[ -d "$TMPDIR" ]] && rm -rf "$TMPDIR"
}
trap cleanup EXIT
trap 'log "Interrupted by user."; exit 130' INT
