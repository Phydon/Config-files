#!/usr/bin/env bash

# dnf last automatic update

set -euo pipefail

history_output=$(sudo dnf5 --color=never history list)

transaction_id=$(
    printf '%s\n' "$history_output" |
    awk '
        $1 ~ /^[0-9]+$/ &&
        $2 ~ /(^|\/)dnf5$/ &&
        $3 == "automatic" &&
        $4 == "--timer" {
            print $1
            exit
        }
    '
)

if [[ -z "$transaction_id" ]]; then
    printf '%s\n' \
        "No dnf5 automatic --timer transaction found." \
        "" \
        "The history command output was:" \
        "$history_output" >&2
    exit 1
fi

sudo dnf5 history info "$transaction_id"

systemctl list-timers dnf5-automatic.timer | rg "NEXT|LEFT|LAST|PASSED" --context 1
