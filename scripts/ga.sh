#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo 'Usage: ga "commit message"'
    exit 1
fi

git add . && \
    git commit -m "$1" && \
    git push
