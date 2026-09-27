#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -gt 0 ]; then
    gio open "$@"
else
    gio open .
fi
