#!/usr/bin/env bash
# =========================================================
# Configuración global de PRO TOOLKIT — V11.1 FULL
# =========================================================

readonly VERSION="V11.1-FULL"
readonly START_TS="$(date +%Y%m%d_%H%M%S)"
readonly LOG_FILE="ProToolkit_${START_TS}.log"
TMPDIR="$(mktemp -d "/tmp/protoolkit_${START_TS}.XXXXXX")" || {
    echo "ERROR: No se pudo crear TMPDIR." >&2
    exit 1
}

HOST=""
ROOT_MODE=false
CONFIRM_AGGRESSIVE=false
ABUSE_API_KEY="${ABUSE_API_KEY:-}"  # Opcional

# -------------------------------
# COLORES PARA SALIDA
# -------------------------------
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
CYAN=$'\e[36m'
RESET=$'\e[0m'

# -------------------------------
# FUNCIÓN LOG (evita errores)
# -------------------------------
log() {
    # Garantiza que siempre exista un mecanismo básico de log
    local msg="$1"
    echo -e "${CYAN}[LOG]${RESET} $msg"
    echo "[LOG] $(date '+%F %T') $msg" >> "$LOG_FILE"
}

log_error() {
    local msg="$1"
    echo -e "${RED}[ERROR]${RESET} $msg"
    echo "[ERROR] $(date '+%F %T') $msg" >> "$LOG_FILE"
}

log_success() {
    local msg="$1"
    echo -e "${GREEN}[OK]${RESET} $msg"
    echo "[OK] $(date '+%F %T') $msg" >> "$LOG_FILE"
}

# -------------------------------
# FUNCIÓN PARA DETECTAR COMANDOS
# -------------------------------
check_cmd() {
    command -v "$1" &>/dev/null
}

# -------------------------------
# LIMPIEZA AUTOMÁTICA
# -------------------------------
cleanup() {
    log "Running cleanup..."

    if [[ -d "$TMPDIR" ]]; then
        rm -rf "$TMPDIR"
        log "Temporary directory removed."
    fi

    log_success "Cleanup completed."
}

trap cleanup EXIT
trap 'log "Interrupted by user (SIGINT). Exiting..."; exit 130' INT
