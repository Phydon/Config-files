function ii
    if count $argv >/dev/null
        gio open $argv
    else
        gio open .
    end
end
