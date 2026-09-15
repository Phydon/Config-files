function cleanup --description "Safely clean up system packages and caches"
    set_color yellow
    echo "--- System Cleanup ---"
    set_color normal

    # Detect package manager
    set -l pkg_mgr ""
    if command -q dnf
        set pkg_mgr dnf
    else if command -q apt
        set pkg_mgr apt
    else
        set_color red
        echo "Error: Supported package manager (dnf or apt) not found."
        set_color normal
        return 1
    end

    set_color cyan
    echo "1. Checking for unused packages..."
    set_color normal

    if test "$pkg_mgr" = dnf
        sudo dnf autoremove --assumeno
    else if test "$pkg_mgr" = apt
        sudo apt --dry-run autoremove
    end

    # Count thumbnails
    set -l thumb_count 0
    if test -d ~/.cache/thumbnails
        set thumb_count (find ~/.cache/thumbnails -type f 2>/dev/null | wc -l | string trim)
    end

    set_color cyan
    echo "2. Checking cache locations..."
    set_color normal
    if test "$thumb_count" -gt 0
        echo "   - Thumbnail cache: $thumb_count files found for deletion"
    else
        echo "   - Thumbnail cache: 0 files found"
    end
    echo "   - $pkg_mgr metadata & package caches will be purged"

    set_color red
    read -l -P "Proceed with removing unused packages and clearing all caches? [y/N] " confirm
    set_color normal

    if test "$confirm" != y -a "$confirm" != Y
        set_color green
        echo "Cleanup aborted. No changes made."
        set_color normal
        return 0
    end

    if test "$pkg_mgr" = dnf
        set_color cyan
        echo "Removing orphaned DNF packages..."
        set_color normal
        sudo dnf autoremove -y

        set_color cyan
        echo "Purging DNF metadata and package caches..."
        set_color normal
        sudo dnf clean all
    else if test "$pkg_mgr" = apt
        set_color cyan
        echo "Removing unneeded APT dependency packages..."
        set_color normal
        sudo apt autoremove -y

        set_color cyan
        echo "Clearing obsolete downloaded APT package archives..."
        set_color normal
        sudo apt autoclean
    end

    if command -q flatpak
        set_color cyan
        echo "Removing unused Flatpak runtimes and libraries..."
        set_color normal
        flatpak uninstall --unused -y
    end

    set_color cyan
    echo "Emptying thumbnail cache..."
    set_color normal
    if test -d ~/.cache/thumbnails
        rm -rf ~/.cache/thumbnails
        echo "Removed $thumb_count thumbnail files."
    else
        echo "No thumbnail cache folder found."
    end

    set_color green
    echo "System cleanup complete!"
    set_color normal
end
