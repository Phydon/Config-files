#!/usr/bin/env bash

set -euo pipefail

# Sudo Keep-alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
# Cleanup keep-alive loop after script ends
SUDO_PID=$!
trap 'kill $SUDO_PID 2>/dev/null || true' EXIT


RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

log_title() { printf " ${YELLOW}--- %s ---${NOCOLOR}\n" "$1"; }
log_info() { printf "${BLUE}[INFO]${NOCOLOR} %s\n" "$1"; }
log_done() { printf "${GREEN}[DONE]${NOCOLOR} %s\n" "$1"; }
log_warn() { printf "${ORANGE}[WARN]${NOCOLOR} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NOCOLOR} %s\n" "$1"; }


log_title "System Cleanup"

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

log_info "Checking for unused packages..."
if [ "$pkg_mgr" = "dnf" ]; then
    sudo dnf autoremove --assumeno
elif [ "$pkg_mgr" = "apt" ]; then
    sudo apt --dry-run autoremove
fi


log_info "Checking cache locations..."
# Count thumbnails
thumb_count=0
if [[ -d "$HOME/.cache/thumbnails" ]]; then
    thumb_count=$(find "$HOME/.cache/thumbnails" -type f 2>/dev/null | wc -l | tr -d ' ')
fi

if [[ "$thumb_count" -gt 0 ]]; then
    echo "   - Thumbnail cache: $thumb_count files found for deletion"
else
    echo "   - Thumbnail cache: 0 files found"
fi
echo "   - $pkg_mgr metadata & package caches will be purged"


printf "${ORANGE}[WARN]${NOCOLOR} Proceed with removing unused packages and clearing all caches? [y/N] "
read -rp "" confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    log_done "Cleanup aborted. No changes made."
    exit 0
fi


if [[ "$pkg_mgr" = "dnf" ]]; then
    log_info "Removing orphaned DNF packages..."
    sudo dnf autoremove -y

    log_info "Purging DNF metadata and package caches..."
    sudo dnf clean all
elif [[ "$pkg_mgr" = "apt" ]]; then
    log_info "Removing unneeded APT dependency packages..."
    sudo apt autoremove -y

    log_info "Clearing obsolete downloaded APT package archives..."
    sudo apt autoclean
fi

if command -v flatpak >/dev/null; then
    log_info "Removing unused Flatpak runtimes and libraries..."
    flatpak uninstall --unused -y
fi

log_info "Emptying thumbnail cache..."
if [[ -d "$HOME/.cache/thumbnails" ]]; then
    rm -rf "$HOME/.cache/thumbnails"
    echo "Removed $thumb_count thumbnail files."
else
    echo "No thumbnail cache folder found."
fi

log_done "System cleanup complete!"
