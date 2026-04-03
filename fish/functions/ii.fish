function ii --description 'open folder from given path or current directory with default file manager'
    if count $argv >/dev/null
        gio open $argv
    else
        gio open .
    end
end
