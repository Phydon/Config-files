function knb --description 'Search and display Markdown files'
    # knb directory to search in
    set -l knb_dir "$HOME/Nextcloud/Obsidian"

    if test (count $argv) -eq 0
        echo "Usage: knb <pattern>"
        return 1
    end

    set -l pattern $argv[1]

    set -l matches (fd -i -t f -e md -- "$pattern" "$knb_dir")

    set -l count (count $matches)

    if test $count -eq 0
        # fallback: if no matches, browse all files in the directory via fzf
        set -l all_files (fd -i -t f -e md . "$knb_dir")
        set -l selection (printf "%s\n" $all_files | fzf --query "$pattern" --header "Fuzzy Search: $knb_dir" --height 50% --reverse --border)

        if test -n "$selection"
            bat --style="plain" -- "$selection"
        end

    else if test $count -eq 1
        bat --style="plain" -- $matches[1]
    else
        # multiple matches: use fzf to narrow down the specific results
        set -l selection (printf "%s\n" $matches | fzf --header "Multiple matches found" --height 50% --reverse --border)

        if test -n "$selection"
            bat --style="plain" -- "$selection"
        end
    end
end
