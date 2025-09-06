#!/bin/bash

# This script is part of the GSA system and provides a safe and consistent
# way to execute any script selected by the user from the interactive menu. 
#
# Its purpose is to centralize the execution logic so that all scripts are run 
# with proper confirmation and visibility. 
# 
# The script prompts the user to confirm before running a selected script, 
# makes the script executable if necessary, and displays clear status messages.
# 
# This file does not contain the scripts themselves; it acts
# as a controlled wrapper to run them in a predictable and developer-friendly manner.

# Set a shell safety pattern.
#
# Flag e - Exit the script immediately if any command returns a non-zero exit code.
# Flag u - Treat undefined variables as an error and exit immediately.
# Flag o - Set the exit status of the pipeline is the exit status of the last command
set -euo pipefail

# Define relevant directory locations and latest build version numbers.
setup_dev_env() {
    # Declare the working directory path.
    WORKING_DIR_ARR=(*)
    if [[ -n "${ZSH_VERSION-}" ]]; then
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
    if [[ "$CURRENT_DIR_NAME" == "generic_shop_app" ]]; then
        break
    fi
    done
    PROJECT_DIR="${PROJECT_DIR%?}"
    SCRIPT_DIR="$PROJECT_DIR/scripts"
    TEMP_DIR="$PROJECT_DIR/temp"

    # Export ENV variables for build versioning.
    if [[ -z "${GSA_VERSION-}" || $0 == ".source-env.sh" ]]; then
    echo
    # Define the library version number.
    export GSA_BUILD_VERSION="$(date +%Y.%m.%d)"
    echo "GSA_BUILD_VERSION $GSA_BUILD_VERSION"
    # Define the build version number.
    export GSA_BUILD_NUMBER="$(sh $SCRIPT_DIR/generate/build-number.sh)"
    echo "GSA_BUILD_NUMBER $GSA_BUILD_NUMBER"
    # Export library and app version numbers.
    export GSA_VERSION="$GSA_BUILD_VERSION.$GSA_BUILD_NUMBER"
    echo "GSA_VERSION $GSA_VERSION"
    fi
}

# Helper method used for printing a visual separator.
print_separator() { echo $'\n--------------------------------\n'; }

# Method used for exiting the script with no error codes.
exit_runner() {
  echo $'\nExiting.\n'
  exit 0
}

# Run the environment setup script to gather relevant directory locations.
setup_dev_env

# Change working directory to the "scripts" directory.
cd $SCRIPT_DIR

# Define script category directory names.
DIRS=(deploy generate setup)

# Properties holding the values of the currently-selected directory and script.
SELECTED_DIR=""
SELECTED_SCRIPT=""

# Provides a utility for selecting a script directory.
menu_select_dir() {
  while true; do
    echo
    echo $'Select a category (or Q to quit):\n'
    for i in "${!DIRS[@]}"; do
      dir="${DIRS[$i]}"
      echo "$((i+1))) $dir"
      # Display directory documentation
      dir_doc_file="${dir}/_${dir}.md"
      if [ -f "$dir_doc_file" ]; then
          sed 's/^/   /' "$dir_doc_file"
      else
          echo "   No documentation found (.md)"
      fi
      echo
    done

    read -rp "Enter choice number (or Q to quit): " choice
    if [[ "$choice" =~ ^[Qq]$ ]]; then
      exit_runner
    elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#DIRS[@]}" ]; then
      SELECTED_DIR="${DIRS[$((choice-1))]}"
      return
    else
      echo "Invalid choice, try again."
    fi
  done
}

# Displays script documentation from top file comments.
show_script_doc() {
    local script="$1"
    local title="$2"
    local found=0
    local capturing=0

    echo
    echo "$title"
    print_separator

    while IFS= read -r line; do
        # Skip shebang
        [[ "$line" =~ ^#! ]] && continue

        # Remove leading spaces
        local trimmed="${line#"${line%%[![:space:]]*}"}"

        # Skip leading empty lines before doc
        if [[ $capturing -eq 0 && -z "$trimmed" ]]; then
            continue
        fi

        # Start capturing when line starts with #
        if [[ "$trimmed" =~ ^# ]]; then
            capturing=1
            found=1
            # Strip leading # and optional space
            doc_line="${trimmed#\#}"
            doc_line="${doc_line# }"
            echo "$doc_line"
        else
            # Stop capturing at first non-# line after starting
            [[ $capturing -eq 1 ]] && break
        fi
    done < "$script"

    if [[ $found -eq 0 ]]; then
        echo "   No documentation found."
    fi

    print_separator
}

# Displays a menu for specifying a script to run.
menu_select_script() {
  while true; do
    scripts=()
    for s in "$SELECTED_DIR"/*.sh; do
      [[ -f "$s" ]] || continue
      scripts+=("$s")
    done

    if [ ${#scripts[@]} -eq 0 ]; then
      echo "No scripts found in $SELECTED_DIR."
      return 1
    fi

    clear
    echo
    echo "Scripts in '$SELECTED_DIR':"
    echo
    for j in "${!scripts[@]}"; do
      sidx=$((j+1))
      echo "$sidx) ${scripts[$j]}"
    done
    echo

    read -rp "Enter choice number (B to go back, Q to quit): " sc
    if [[ "$sc" =~ ^[Qq]$ ]]; then
      exit_runner
    elif [[ "$sc" =~ ^[Bb]$ ]]; then
      clear
      return 1
    fi

    if [[ "$sc" =~ ^[0-9]+$ ]] && [ "$sc" -ge 1 ] && [ "$sc" -le "${#scripts[@]}" ]; then
      SELECTED_SCRIPT="${scripts[$((sc-1))]}"
      return 0
    else
      echo "Invalid choice, try again."
    fi
  done
}

#  Method used for running of the selected script.
run_script() {
  # Show documentation only now
  show_script_doc "$SELECTED_SCRIPT" "Documentation for $SELECTED_SCRIPT:"
  read -rp "Run this script? [y/N]: " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    chmod +x "$SELECTED_SCRIPT"
    print_separator
    echo "Executing $SELECTED_SCRIPT"
    print_separator
    source "$SELECTED_SCRIPT"
    print_separator
    echo "Finished running $SELECTED_SCRIPT"
  else
    echo
    echo "Skipped $SELECTED_SCRIPT"
  fi
}

echo $'\nGSA Script Runner'

print_separator

# Start the main infinite loop for the script runner.
while true; do
    # Show the directory/category selection menu.
    menu_select_dir

    # Start an inner loop to select and run scripts within the chosen directory.
    while true; do
        # Show the script selection menu.
        # If the user chooses to go back, break the inner loop.
        menu_select_script || break

        # Execute the selected script.
        run_script
    done
done
