#!/bin/bash
tmuxsessions=$(tmux list-sessions -F "#{session_name}")

tmux_switch_to_session() {
    session="$1"
    if [ "$session" == "^[" ]; then
        echo "escape key pressed, not switching sessions"
        return
    fi
    if [[ $tmuxsessions = *"$session"* ]]; then
        tmux switch-client -t "$session"
    fi
}

choice=$(sort -rfu <<< "$tmuxsessions" \
    | fzf-tmux -e -p \
    | tr -d '\n') 

if [ -z "$choice" ]; then
    # echo "escape key pressed, not switching sessions"
    exit
else
    tmux_switch_to_session "$choice"
fi
