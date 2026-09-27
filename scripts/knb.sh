#!/usr/bin/env bash
set -euo pipefail

knb_dir="${KNB_DIR:-$HOME/Nextcloud/Obsidian}"

if [ "$#" -eq 0 ]; then
    echo "Usage: knb <pattern>" >&2
    exit 1
fi

if [ ! -d "$knb_dir" ]; then
    echo "knb: directory not found: $knb_dir" >&2
    exit 1
fi

pattern="$*"

fd_bin=$(command -v fd || command -v fdfind || true)
bat_bin=$(command -v bat || command -v batcat || true)
[ -n "$fd_bin" ]  || { echo "knb: fd not found" >&2; exit 1; }
[ -n "$bat_bin" ] || { echo "knb: bat not found" >&2; exit 1; }
command -v fzf >/dev/null || { echo "knb: fzf not found" >&2; exit 1; }

# shared fzf options, including the live preview
fzf_opts=(
    --height 80%
    --reverse
    --border
    --preview "'$bat_bin' --color=always --style=plain -- {}"
    --preview-window "right,60%,wrap"
)

mapfile -t matches < <("$fd_bin" -i -t f -e md -- "$pattern" "$knb_dir")

selection=""
case "${#matches[@]}" in
    0)
        # no filename match: fuzzy-browse everything, pre-filled with the pattern
        selection=$("$fd_bin" -i -t f -e md . "$knb_dir" \
            | fzf "${fzf_opts[@]}" \
                  --query "$pattern" \
                  --header "Fuzzy Search: $knb_dir" || true)
        ;;
    1)
        selection="${matches[0]}"
        ;;
    *)
        selection=$(printf '%s\n' "${matches[@]}" \
            | fzf "${fzf_opts[@]}" \
                  --header "Multiple matches found" || true)
        ;;
esac

if [ -n "$selection" ]; then
    "$bat_bin" --style=plain -- "$selection"
fi
