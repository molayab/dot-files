# Zsh Configuration Guide

## Overview

This .zshrc configuration provides a clean, organized, and efficient environment for macOS development, especially for iOS/Xcode and Android development. The configuration includes custom functions for handling common development tasks, such as managing Xcode processes and workspaces.

The .zshrc file is organized into distinct sections:
- Basic Oh My Zsh configuration
- Environment variables and PATH
- Plugin configuration
- Aliases
- Functions

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

## Installation
1. Ensure Zsh and Oh My Zsh are installed on your system
2. Install the molayab theme
3. Copy the .zshrc file to your home directory:
   ```
   cp .zshrc ~/.zshrc
   ```
4. Source the file to apply changes:
   ```
   source ~/.zshrc
   ```

If moving to a new computer, the configuration uses relative paths with `$HOME` references, so it should work without modification.

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
