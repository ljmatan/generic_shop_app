#!/bin/bash

# Run the Dart build_runner package to generate model class serialization code.
#
# References:
# 
# - https://pub.dev/packages/json_serializable
#
# Example usage:
# 
# - Run the script, invoking the `dart` command.
# `sh scripts/build-models.sh`

# Define script and project directory locations.
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
PROJECT_DIR="$SCRIPT_DIR/.."

cd $PROJECT_DIR/plugins/api

dart run build_runner build --delete-conflicting-outputs