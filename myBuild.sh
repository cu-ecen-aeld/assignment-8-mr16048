# Save the original PATH
ORIGINAL_PATH=$PATH

# Clean the PATH for the build
# Remove paths that contain spaces
CLEAN_PATH=$(echo "$ORIGINAL_PATH" | tr ':' '\n' | grep -v ' ' | tr '\n' ':')

# Remove current directory (.) from PATH
CLEAN_PATH=$(echo "$CLEAN_PATH" | tr ':' '\n' | grep -v '^\.$' | tr '\n' ':')

# Remove empty entries (::) and trailing colons (:)
CLEAN_PATH=$(echo "$CLEAN_PATH" | sed -e 's/::/:/g' -e 's/:$//')

# Export the cleaned PATH for the build
export PATH=$CLEAN_PATH

# Run make (build)
./build.sh

# Restore the original PATH after the build
export PATH=$ORIGINAL_PATH
