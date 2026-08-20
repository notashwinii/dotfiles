#!/usr/bin/env bash

set -euo pipefail

choice="$(cliphist list | wofi --dmenu --prompt Clipboard)" || exit 0
[ -n "$choice" ] || exit 0
printf '%s' "$choice" | cliphist decode | wl-copy
