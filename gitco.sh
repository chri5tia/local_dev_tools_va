#!/bin/bash

# Handy git checkout shortcut

# Set up instructions
# Add an alias to your shell profile
# Example: ~/.bash_profile, ~/.bashrc or ~/.zshrc
#
# alias gitco='/path/to/gitco.sh'

if [ -n "$1" ]; then
    ticket="$1";
    target=$(git branch | grep "$ticket")
    git checkout $target
else
    read -p "Supply a ticket ID so I can checkout the branch for it. " ticket
    target=$(git branch | grep "$ticket")
    git checkout $target
fi