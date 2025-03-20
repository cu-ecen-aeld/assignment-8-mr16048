#!/bin/bash

# Save the original PATH
ORIGINAL_PATH="$PATH"

# Remove spaces, TABs, and newlines from PATH
export PATH=$(echo "$PATH" | tr -d ' \t\n')

# Run some commands (example: compiling Buildroot)
./build.sh

# Restore the original PATH
export PATH="$ORIGINAL_PATH"
