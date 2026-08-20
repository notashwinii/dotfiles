#!/usr/bin/env bash

set -euo pipefail

directory="$HOME/Pictures/Screenshots"
mkdir -p "$directory"
filename="$directory/$(date +%Y%m%d-%H%M%S).png"

# Escape cancels selection without creating an empty capture.
region="$(slurp -d)" || exit 0
grim -g "$region" "$filename"
wl-copy --type image/png < "$filename"
