#!/usr/bin/env bash

set -euo pipefail

# Sudo Keep-alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
# Cleanup keep-alive loop after script ends
SUDO_PID=$!
trap 'kill $SUDO_PID 2>/dev/null || true' EXIT


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

log_title() { printf " ${YELLOW}--- %s ---${NOCOLOR}\n" "$1"; }
log_info() { printf "${BLUE}[INFO]${NOCOLOR} %s\n" "$1"; }
log_done() { printf "${GREEN}[DONE]${NOCOLOR} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NOCOLOR} %s\n" "$1"; }

log_title "Updating System"

# Detect package manager
pkg_mgr=""
if command -v dnf >/dev/null; then
    pkg_mgr="dnf"
elif command -v apt >/dev/null; then
    pkg_mgr="apt"
else
    log_error "Package Manager not supported"
    exit 1
fi

log_info "Updating system packages..."
if [ "$pkg_mgr" = "dnf" ]; then
    sudo dnf upgrade --refresh -y
elif [ "$pkg_mgr" = "apt" ]; then
    sudo apt-get update && sudo apt-get upgrade -y
fi

if command -v flatpak >/dev/null; then
    log_info "Updating Flatpaks..."
    flatpak update -y
fi

if command -v rustup >/dev/null; then
    log_info "Updating Rust..."
    rustup update
fi

if command -v pipx >/dev/null; then
    log_info "Updating Pipx applications..."
    PIPX_USE_EMOJI=0 pipx upgrade-all
fi

log_done "System update complete!"
