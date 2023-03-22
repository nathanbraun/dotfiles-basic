#!/bin/bash

BASE="$HOME/code/github.com"
dirs=$(find "$BASE" -mindepth 2 -maxdepth 2 -type d | sed "s|$BASE/||g")

choice=$(sort -rfu <<< "$dirs" \
    | fzf-tmux -e -p \
    | tr -d '\n') 
if [ -z "$choice" ]; then
    # echo "escape key pressed, not switching sessions"
    exit
else
  tmux-session "$BASE/$choice"
fi
