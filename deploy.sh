#!/bin/bash

# --- Configuration ---
DOTFILES_REPO_DIR="$(pwd)"
SOURCE_DIR="$DOTFILES_REPO_DIR/home"
TARGET_HOME="$HOME"

# --- Main Logic ---

echo "Starting dotfiles symbolic link deployment..."

# 1. --- HANDLE EXPLICIT DIRECTORY LINKS (Add these manually) ---
echo "Handling special directory links..."
# Example: Linking the Neovim lua folder explicitly
SOURCE_LUA="$SOURCE_DIR/.config/nvim/lua"
TARGET_LUA="$TARGET_HOME/.config/nvim/lua"

if [ -d "$SOURCE_LUA" ]; then
    # Ensure the parent directory exists
    mkdir -p "$(dirname "$TARGET_LUA")"

    # Remove existing target if it's not a link or not the link we want
    rm -rf "$TARGET_LUA"

    # Create the symbolic link for the entire directory
    ln -s "$SOURCE_LUA" "$TARGET_LUA"
    echo "Linked directory: $TARGET_LUA"
fi
# -----------------------------------------------------------------


# 2. --- LINK INDIVIDUAL FILES ---

find "$SOURCE_DIR" -type f -print0 | while IFS= read -r -d $'\0' SOURCE_PATH; do

    # Skip files that are part of the explicitly linked directories (like those inside 'lua')
    # This prevents the file-by-file loop from touching files inside a linked directory.
    if [[ "$SOURCE_PATH" == */.config/nvim/lua/* ]]; then
        continue
    fi

    RELATIVE_PATH="${SOURCE_PATH#$SOURCE_DIR/}"
    TARGET_PATH="$TARGET_HOME/$RELATIVE_PATH"

    # Create target directories if they don't exist
    TARGET_DIR="$(dirname "$TARGET_PATH")"
    mkdir -p "$TARGET_DIR"

    # Create the Symbolic Link (Soft Link)
    echo "Linking file: $SOURCE_PATH -> $TARGET_PATH"
    ln -sfn "$SOURCE_PATH" "$TARGET_PATH"

done

echo "Deployment complete."
