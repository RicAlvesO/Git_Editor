#!/bin/sh

custom_commit=0

# Parse command line options
while getopts ":e:f:c" opt; do
  case $opt in
    e)
      # Override GN_EDITOR if -e flag is provided
      GN_EDITOR="$OPTARG"
      ;;
    f)
      # Override GN_FOLDER if -f flag is provided
      GN_FOLDER="$OPTARG"
      ;;
    c)
      # Override default commit message if -c flag is provided
      custom_commit=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Save current folder
current_folder=$(pwd)

# Determine the shell configuration file
shell_config_file=""
if [ "${SHELL##*/}" != "zsh" ]; then
    shell_config_file="$HOME/.bashrc"
else
    shell_config_file="$HOME/.zshrc"
fi

# Verify configuration
reload=0

# Check if notes_folder is set
if [ -z "$GN_FOLDER" ]; then
    # If not set, prompt the user and set it in the appropriate configuration file
    echo "Please provide the path for the notes folder:"
    read -r notes_folder_input

    # Set notes_folder in the appropriate configuration file
    echo "export GN_FOLDER='$notes_folder_input'" >> "$shell_config_file"
    # Reload the configuration file
    reload=1
fi

# Check if default_editor is set
if [ -z "$GN_EDITOR" ]; then
    # If not set, prompt the user and set it in the appropriate configuration file
    echo "Please provide the default editor:"
    read -r default_editor_input

    # Set default_editor in the appropriate configuration file
    echo "export GN_EDITOR='$default_editor_input'" >> "$shell_config_file"
    # Reload the configuration file
    reload=1
fi

# Warn to reaload console
if [ "$reload" -eq 1 ]; then
    echo "$default_editor_input updated! Please reload the terminal!"
    exit 1
fi

# Get notes folder and default editor from ENV
notes_folder="$GN_FOLDER"
default_editor="$GN_EDITOR"  # Default to nano if default_editor is not set

# Verify folder exists and is a git repository
if [ ! -d "$notes_folder/.git" ]; then
    echo "ERROR: Notes folder is not a git repository or doesn't exist."
    exit 1
fi

# Change to notes folder
cd "$notes_folder" || exit 1

# Update Repo
git pull

# Open default editor
$default_editor .

commit_message="GitNotes Auto Save"

if [ "$custom_commit" -eq 1 ]; then
    echo "Please provide the commit message:"
    read -r commit_message
fi

# Save the repo
git add .
git commit -m "$commit_message"
git push

# Return to previous folder
cd "$current_folder" || exit 1

