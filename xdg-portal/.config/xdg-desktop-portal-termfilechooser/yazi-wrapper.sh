#!/usr/bin/env bash
# Yazi file picker for xdg-desktop-portal-termfilechooser
set -e

save="$3"
path="$4"
out="$5"

# Start directory
start_dir="$([[ -d "$path" ]] && echo "$path" || dirname "$path" 2>/dev/null || echo "$HOME")"
[[ ! -d "$start_dir" ]] && start_dir="$HOME"

if [[ "$save" = "1" ]]; then
    # Save mode: select folder → gum prompt for filename
    suggested=$(basename "$path" 2>/dev/null); [[ -z "$suggested" ]] && suggested="untitled"
    tmp=$(mktemp)
    
    yazi "$start_dir" --chooser-file="$tmp"
    [[ ! -s "$tmp" ]] && { rm -f "$tmp"; exit 1; }
    
    sel=$(cat "$tmp"); rm -f "$tmp"
    dir=$([[ -d "$sel" ]] && echo "$sel" || dirname "$sel")
    
    name=$(/usr/bin/gum input --value "$suggested" --header "Save to: $dir/")
    [[ -z "$name" ]] && exit 1
    
    final="$dir/$name"
    touch "$final"
    echo "$final" > "$out"
else
    # Open/directory mode: direct selection
    yazi "$start_dir" --chooser-file="$out"
fi