#!/bin/bash

# Set the user's home directory and backup directory
HOME_DIR="$HOME"
BACKUP_DIR="$HOME/config_backup"

# List of dotfiles and dot-directories to backup or restore
CONFIG_LIST=(
  ".zshrc"
  ".tmux"
  ".config"
)

# Function to backup dotfiles and dot-directories
backup() {
  # Create the backup directory if it doesn't exist
  mkdir -p "$BACKUP_DIR"

  for item in "${CONFIG_LIST[@]}"; do
    if [ -e "$HOME_DIR/$item" ]; then
      mv -v "$HOME_DIR/$item" "$BACKUP_DIR"
    fi
  done

  echo "Dotfiles and dot-directories backup completed. Backup is stored in $BACKUP_DIR"
}

# Function to restore dotfiles and dot-directories from the backup directory
restore() {
  if [ -d "$BACKUP_DIR" ]; then
    for item in "${CONFIG_LIST[@]}"; do
      if [ -e "$BACKUP_DIR/$item" ]; then
        mv -v "$BACKUP_DIR/$item" "$HOME_DIR"
      fi
    done

    echo "Dotfiles and dot-directories restored from $BACKUP_DIR"
  else
    echo "Backup directory $BACKUP_DIR not found. Cannot restore."
  fi
}

# Check command line arguments
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {backup|restore}"
  exit 1
fi

if [ "$1" = "backup" ]; then
  backup
elif [ "$1" = "restore" ]; then
  restore
else
  echo "Invalid option. Usage: $0 {backup|restore}"
  exit 1
fi
