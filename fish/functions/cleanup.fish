function cleanup --description "Safely clean up system packages and caches"
    set_color yellow
    echo "--- System Cleanup ---"
    set_color normal

    set_color cyan
    echo "Checking for unused packages (Dry Run)..."
    set_color normal
    sudo apt --dry-run autoremove

    set_color red
    read -l -P "Proceed with removing these packages and clearing caches? [y/N] " confirm
    set_color normal

    if test "$confirm" != y -a "$confirm" != Y
        set_color green
        echo "Cleanup aborted. No changes made."
        set_color normal
        return 0
    end

    set_color cyan
    echo "Executing package cleanup..."
    set_color normal
    sudo apt autoremove -y
    sudo apt autoclean

    set_color cyan
    echo "Emptying thumbnail cache..."
    set_color normal
    rm -rf ~/.cache/thumbnails/*

    set_color green
    echo "System cleanup complete!"
    set_color normal
end
