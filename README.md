# Git Editor

Simple script for editing GitHub repositories with automatic syncing to upstream.

## Installation

Inside the root of this project simply run:

```
sudo ln -s "$(pwd)/src/git_edit.sh" /usr/local/bin/ged
```

Doing so will allow you to run the command from any location by creating a symlink to the executable.

After that you can run the program for the first time by running:

```
./src/git_edit.sh
```

This will prompt you for a default folder and your default editor.
Note that your editor should allow for opening and navigating folders. 
Additionally the folder should be a github folder, as it will be used to sync all the notes among devices. 
For more information on how to create your own repository for saving all your notes check this [GitHub article](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository).

Afterwards the program will exit and you should reload your current terminal to update all the settings.
This can be done by running:

```
source $HOME/.bashrc
```

Or, for ZSH:

```
source $HOME/.zshrc
```

## Usage

To use this program, after the installation process is completed, simply type `ged` in your terminal. 
This will `pull` your notes from the upstream repository and open your desired editor.
Once you completed the desired changes simply exit the editor and the changes will be automatically added to GitHub.

### Flags

To open different folders or editors you can use the flags bellow. Additionally you can costumize the commit message with `-c`.

| Flag |      Description      |
|------|-----------------------|
|   -c | Custom commit message |
|   -e | Custom editor         |
|   -f | Custom git folder     |

#### Example Usage:

Open the current folder with default editor:

```
ged -f .
```

Open default folder with custom editor:

```
ged -e code
```

Open a custom folder with costum editor:

```
ged -e code -f /path/to/folder
```

Edit the current folder and add a custom commit:

```
ged -f . -c
```
