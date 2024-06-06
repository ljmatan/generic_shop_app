#!/usr/bin/env zsh

# Sets up the development environment for script execution and SDK channel management.
#
# Example usage:
#
# source ./scripts/dev-env-setup.sh

# Declare the working directory path.
WORKING_DIR_ARR=(*)
if [[ -n "$ZSH_VERSION" ]]; then
    # Use Zsh-specific method
    WORKING_DIR_ARR=( ${(s:/:)PWD} )
else
    # Use Bash-specific method
    IFS="/" read -ra WORKING_DIR_ARR <<< "$(pwd)"
fi
PROJECT_DIR=""
# Extract the project directory path from the working directory.
for ((DIR_NAME_I=0; DIR_NAME_I<=${#WORKING_DIR_ARR[@]}; DIR_NAME_I++)); do
  CURRENT_DIR_NAME="${WORKING_DIR_ARR[$DIR_NAME_I]}"
  PROJECT_DIR+="$CURRENT_DIR_NAME/"
  if [[ "$CURRENT_DIR_NAME" == "ia_mobile_library" ]]; then
    break
  fi
done
PROJECT_DIR="${PROJECT_DIR%?}"
SCRIPT_DIR="$PROJECT_DIR/scripts"
TEMP_DIR="$PROJECT_DIR/temp"

# Define the Flutter executable path.
FLUTTER_EXEC="$PROJECT_DIR/flutter"

# Set up the Flutter command symbolic link.
if [ ! -e "$FLUTTER_EXEC" ]; then
  ln -s "$(which flutter)" "$PROJECT_DIR/flutter"
fi

# Export ENV variables for build versioning.
if [[ -z "$GSA_LIB_VERSION" || $0 == "dev-env-setup.sh" ]]; then
  # Define the library version number.
  export GSA_BUILD_VERSION="$(date +%Y.%m.%d)"
  echo "GSA_BUILD_VERSION $GSA_BUILD_VERSION"
  # Define the build version number.
  export GSA_BUILD_NUMBER="$(sh $SCRIPT_DIR/echo-day-mins.sh)"
  echo "GSA_BUILD_NUMBER $GSA_BUILD_NUMBER"
  # Export library and app version numbers.
  export GSA_LIB_VERSION="$GSA_BUILD_VERSION.$GSA_BUILD_NUMBER"
  echo "GSA_LIB_VERSION $GSA_LIB_VERSION"
fi
