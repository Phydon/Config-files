function scope-connect
    sudo ip addr add 192.168.1.1/24 dev enp0s31f6
end

function scope-disconnect
    sudo ip addr del 192.168.1.1/24 dev enp0s31f6
end
