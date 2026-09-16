function up --description "Update system, flatpak, apps, rust, pip"
    set_color yellow
    echo "--- Updating System ---"
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
    echo "Updating system packages ($pkg_mgr)..."
    set_color normal

    if test "$pkg_mgr" = dnf
        sudo dnf upgrade --refresh -y
    else if test "$pkg_mgr" = apt
        sudo apt update && sudo apt upgrade -y
    end

    if command -q flatpak
        set_color cyan
        echo "Updating Flatpaks..."
        set_color normal
        flatpak update -y
    end

    if command -q rustup
        set_color cyan
        echo "Updating Rust..."
        set_color normal
        rustup update
    end

    if command -q python3
        set_color cyan
        echo "Updating Pip..."
        set_color normal
        python3 -m pip install --upgrade pip
    end

    set_color green
    echo "System update complete!"
    set_color normal
end
