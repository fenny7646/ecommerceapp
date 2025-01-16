#!/bin/bash

# File to store the counter
COUNTER_FILE=".commit_counter"

# Check if the counter file exists; if not, initialize it with 0
if [ ! -f "$COUNTER_FILE" ]; then
    echo 0 > "$COUNTER_FILE"
fi

# Read the current counter value
counter=$(cat "$COUNTER_FILE")

# Display the current counter value
echo "Current Commit Counter: C${counter}"

# Ask if the user wants to set a new counter for future commits
read -p "Do you want to set a new counter for future commits? [Y/N]? " change_counter

if [[ "$change_counter" == "Y" || "$change_counter" == "y" ]]; then
    # User wants to set a new counter for future commits
    read -p "Enter new commit number: " new_counter

    # Save the new counter value back to the file for future use
    echo "$new_counter" > "$COUNTER_FILE"
    echo "Commit Counter updated to: C${new_counter}"
    counter="$new_counter"

else
    # Increment the counter
    new_counter=$((counter + 1))
    # Save the updated counter back to the file for future use
    echo "$new_counter" > "$COUNTER_FILE"
fi

# Get the current date and time
current_date=$(date +"%A, %B %d, %Y, %-I:%M %p %Z")

# Prompt for the commit message with the counter and date
read -p "Enter the commit message [No: C${counter} | Date: ${current_date}]: " commit_message

# Format the commit message with autoincremented number and user input
formatted_message="C${counter}-${commit_message}"

# Format the commit message with autoincremented number and user input
formatted_message="C${counter}-${commit_message}"

# Define an array of remote repositories and their values
declare -A remote_values=( ["origin"]="" ["ecommerce"]=1 )
remote_repos=("origin" "ecommerce")

# Display available remote repositories and prompt user to select one
echo "Available remote repositories:"
for i in "${!remote_repos[@]}"; do
    echo "$i: ${remote_repos[$i]}"
done

read -p "Select a remote repository by index (default: 0 for 'origin'): " repo_index

# Default to 'origin' if no input is provided
repo_index=${repo_index:-0}
selected_repo=${remote_repos[$repo_index]}

# Check if a value exists for the selected repository in remote_values
repo_value=${remote_values[$selected_repo]}
if [[ -n "$repo_value" ]]; then
    echo "Selected repository '$selected_repo' has a value of '$repo_value'."
else
    echo "Selected repository '$selected_repo' has no associated value."
fi

# Run Git commands (example)
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

echo "Pushing changes to $selected_repo..."
if ! git push -u "$selected_repo" main; then
    echo "Error: Failed to push changes to $selected_repo."
    exit 1
fi

echo "Changes pushed successfully with commit message: $formatted_message"
