#!/bin/bash

# Prompt for commit message with a default value
read -p "Enter the commit message [Default: 'Updated files']: " commit_message
commit_message=${commit_message:-Updated files}

# Prompt for remote repository with a default value
read -p "Enter the remote repository name [Default: 'origin']: " remote_name
remote_name=${remote_name:-origin}

# Run Git commands
git add .
git commit -m "$commit_message"
git push -u "$remote_name" main
