#!/bin/bash

# File to store the counter
COUNTER_FILE=".commit_counter"

# Check if the counter file exists; if not, initialize it with 0
if [ ! -f "$COUNTER_FILE" ]; then
    echo 0 > "$COUNTER_FILE"
fi

# Read the current counter value
counter=$(cat "$COUNTER_FILE")

# Increment the counter
counter=$((counter + 1))

# Save the new counter value back to the file
echo "$counter" > "$COUNTER_FILE"

# Prompt for the commit message
echo "Enter the commit message:"
read commit_message

# If no commit message is entered, exit with an error
if [ -z "$commit_message" ]; then
    echo "Error: Commit message cannot be empty."
    exit 1
fi

# Format the commit message with autoincremented number
formatted_message="C${counter}-${commit_message}"

# Prompt for the remote repository name (default: origin)
read -p "Enter the remote repository name (default: origin): " remote_name

# Use "origin" as default if no remote name is provided
remote_name=${remote_name:-origin}

# Run Git commands with error handling
echo "Staging changes..."
if ! git add .; then
    echo "Error: Failed to stage changes."
    exit 1
fi

echo "Committing changes..."
if ! git commit -m "$formatted_message"; then
    echo "Error: Failed to commit changes. Make sure there are changes to commit."
    exit 1
fi

echo "Pushing changes to $remote_name..."
if ! git push -u "$remote_name" main; then
    echo "Error: Failed to push changes to $remote_name."
    exit 1
fi

echo "Changes pushed successfully with commit message: $formatted_message"

