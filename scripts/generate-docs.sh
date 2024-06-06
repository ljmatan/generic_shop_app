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

# Build the frontend project documentation.
cd $PROJECT_DIR
dartdoc --output="$PROJECT_DIR/middleware/store/hosting/docs-fe" .

# Build the API project documentation.
cd $PROJECT_DIR/api
dartdoc --output="$PROJECT_DIR/middleware/store/hosting/docs-api" .

# Build the CMS project documentation.
cd $PROJECT_DIR/cms
dartdoc --output="$PROJECT_DIR/middleware/store/hosting/docs-cms" .

# Build the server middleware project documentation.
cd $PROJECT_DIR/middleware
dartdoc --output="$PROJECT_DIR/middleware/store/hosting/docs-be" .