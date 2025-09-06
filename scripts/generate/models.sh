#!/bin/bash

# Run the Dart build_runner package to generate model class serialization code.
#
# References:
# 
# https://pub.dev/packages/json_serializable
#
# Example usage:
# 
# $ sh scripts/build-models.sh

echo "AAAAA"
echo $PROJECT_DIR

cd $PROJECT_DIR/core/api

dart run build_runner build --delete-conflicting-outputs