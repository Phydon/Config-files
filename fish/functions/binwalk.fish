function binwalk
    # no arguments, show help and exit
    if not set -q argv[1]
        sudo docker run --rm binwalkv3 --help
        return
    end

    # using (pwd) ensures the container maps current location
    set -l current_dir (pwd)

    # --rm: Deletes the container after the scan finishes
    # -it: Keeps the process interactive (for progress bars)
    # -v: Links your current folder to the container's analysis folder
    # -w: Tells the container to start inside the /analysis folder
    # -u: Matches the container's user ID to YOUR user ID (prevents root-owned files)
    sudo docker run --rm -it \
        -v "$current_dir":/analysis \
        -w /analysis \
        -u (id -u):(id -g) \
        binwalkv3 $argv
end
