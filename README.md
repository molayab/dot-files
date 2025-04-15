# Zsh Configuration Guide

## Overview

This .zshrc configuration provides a clean, organized, and efficient environment for macOS development, especially for iOS/Xcode and Android development. The configuration includes custom functions for handling common development tasks, such as managing Xcode processes and workspaces.

The .zshrc file is organized into distinct sections:
- Basic Oh My Zsh configuration
- Environment variables and PATH
- Plugin configuration
- Aliases
- Functions

## Quick Start

For the fastest installation:

```bash
git clone https://github.com/molayab/dot-files.git ~/.dot-files && cd ~/.dot-files && chmod +x install.sh && ./install.sh
```

See the [Installation](#installation) section below for detailed instructions and manual installation options.

## Prerequisites

To use this configuration, you need:

- **Zsh** 5.9 or later
- **Oh My Zsh** installed (`https://ohmyz.sh/`)
- **molayab** theme for Oh My Zsh
- The following applications (optional, for full functionality):
  - Visual Studio Code
  - Android Studio
  - Xcode (for macOS development functions)

### Required Plugins

The configuration uses these Oh My Zsh plugins:
- git
- macos
- dotenv
- xcode
- swiftpm
- ssh
- mosh
- brew

## Installation

### Automated Installation (Recommended)

This repository includes an automated installation script that handles the complete setup process:

```bash
# Clone the repository
git clone https://github.com/molayab/dot-files.git ~/.dot-files
cd ~/.dot-files

# Make the script executable
chmod +x install.sh

# Run the installation script
./install.sh
```

The installation script will:
- Verify system prerequisites (Zsh 5.9+)
- Install Oh My Zsh if not already present
- Back up your existing dotfiles to a timestamped directory
- Install all configuration files (.zshrc, .vimrc, .gitconfig, .lesshst)
- Set up the custom theme
- Configure required plugins
- Provide clear instructions for next steps

After installation completes:
1. Start a new terminal session or run: `source ~/.zshrc`
2. Verify that the theme and plugins are working correctly

### Manual Installation

If you prefer to install manually:

1. Ensure Zsh and Oh My Zsh are installed on your system
2. Clone this repository:
   ```bash
   git clone https://github.com/molayab/dot-files.git ~/.dot-files
   ```

3. Back up your existing configuration:
   ```bash
   for file in .zshrc .vimrc .gitconfig .lesshst; do
     [ -f "$HOME/$file" ] && mv "$HOME/$file" "$HOME/$file.backup"
   done
   ```

4. Copy configuration files:
   ```bash
   cp ~/.dot-files/.zshrc ~/.zshrc
   cp ~/.dot-files/.vimrc ~/.vimrc
   cp ~/.dot-files/.gitconfig ~/.gitconfig
   cp ~/.dot-files/.lesshst ~/.lesshst
   ```

5. Install the theme:
   ```bash
   cp ~/.dot-files/themes/molayab.zsh-theme ~/.oh-my-zsh/themes/
   ```

6. Source the configuration:
   ```bash
   source ~/.zshrc
   ```

Note: When moving to a new computer, the configuration uses relative paths with `$HOME` references, so it should work without modification.

## Features and Functions

### Core Functions

#### `code` - Visual Studio Code Launcher

Opens Visual Studio Code from the terminal without requiring admin access.

```zsh
code [file or directory]
```

#### `studio` - Android Studio Launcher

Opens Android Studio with the current directory or a specified path.

```zsh
studio [optional: path]
```

#### `resetWorkspaceEnvironment` - Xcode Workspace Cleaner

Cleans Xcode development environment to free up space and fix common issues.

- Clears Derived Data
- Cleans Swift Package Manager caches
- Removes Xcode module cache
- Optional: Reset iOS simulators
- Optional: Clear Xcode archives
- Provides a summary of space saved

```zsh
resetWorkspaceEnvironment
```

#### `killxcodes` - Xcode Process Terminator

Terminates all Xcode-related processes to free up system resources.

- Kills Xcode application
- Terminates Xcode build daemon
- Stops Xcode device daemon
- Optional: Kill simulator processes
- Optional: Reset workspace environment

```zsh
killxcodes
```

### Aliases
- `zshconfig` - Edit .zshrc file using vim
- `ohmyzsh` - Edit Oh My Zsh configuration


## Usage Examples

### Opening VS Code with the current directory
```zsh
code .
```

### Opening Android Studio with a specific project
```zsh
studio ~/Projects/android-project
```

### Cleaning Xcode workspace to fix build issues
```zsh
resetWorkspaceEnvironment
```

### Killing all Xcode processes when they're unresponsive
```zsh
killxcodes
```

## Customization
To customize this configuration:

1. Edit the .zshrc file:
   ```
   zshconfig
   ```
2. Add new aliases or functions as needed
3. Source the file to apply changes:
   ```
   source ~/.zshrc
   ```
