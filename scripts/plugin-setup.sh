#!/bin/bash

# Clones the plugin repository to the local file directory.

# Check if the first argument is missing or empty
if [ -z "$1" ]; then
  echo "Error: Missing required Git repository URL argument." >&2
  echo "Usage: $0 <repository_url>" >&2
  exit 1
fi

# Define the remote Git repository directory location.
REPO_DIR=$1

# Define the project repository location.
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
PROJECT_DIR="$SCRIPT_DIR/.."

# Define the plugin name.
PLUGIN_ID="${REPO_DIR#https://github.com/ljmatan/generic_shop_app_}"

# Change working directory to the plugin folder.
cd $PROJECT_DIR/plugins/$PLUGIN_ID

# Get the plugin files.
git clone $REPO_DIR

# Move the plugin source files to the relevant location.
mv generic_shop_app_$PLUGIN_ID/* generic_shop_app_$PLUGIN_ID/.* .

# Remove the redundant directory.
rm -rf generic_shop_app_$PLUGIN_ID
