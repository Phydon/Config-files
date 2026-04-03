function cleanup
    echo "Removing unused dependencies..."
    sudo apt autoremove -y
    echo "Clearing package cache..."
    sudo apt autoclean
end
