#!/bin/bash

# Dotfiles installation script
# 
# This script installs dotfiles from the current repository to the user's home directory.
# It includes checks for prerequisites, backups existing files, and configures Zsh with Oh My Zsh.

# Color codes for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Print banner
echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}      Dotfiles Installation      ${NC}"
echo -e "${BLUE}=====================================${NC}\n"

# Print message with appropriate color
print_message() {
    local type=$1
    local message=$2
    
    case $type in
        "info")
            echo -e "${GREEN}[INFO]${NC} $message"
            ;;
        "warn")
            echo -e "${YELLOW}[WARNING]${NC} $message"
            ;;
        "error")
            echo -e "${RED}[ERROR]${NC} $message"
            ;;
    esac
}

# Function to check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to exit on error
exit_error() {
    print_message "error" "$1"
    exit 1
}

# Step 1: Check for Zsh and minimum version requirement
check_zsh() {
    print_message "info" "Checking for Zsh installation..."
    
    if ! command_exists zsh; then
        exit_error "Zsh is not installed. Please install Zsh 5.9 or later."
    fi
    
    # Get Zsh version
    local zsh_version=$(zsh --version | awk '{print $2}')
    print_message "info" "Found Zsh version ${zsh_version}"
    
    # Compare versions
    if [[ "$(printf '%s\n' "5.9" "$zsh_version" | sort -V | head -n1)" != "5.9" ]]; then
        exit_error "Zsh version 5.9 or later is required. You have ${zsh_version}."
    fi
    
    print_message "info" "Zsh version requirement satisfied."
}

# Step 2: Check and install Oh My Zsh if needed
check_oh_my_zsh() {
    print_message "info" "Checking for Oh My Zsh installation..."
    
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        print_message "warn" "Oh My Zsh not found. Installing..."
        
        if ! command_exists curl; then
            exit_error "curl is required to install Oh My Zsh. Please install curl first."
        fi
        
        # Install Oh My Zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
            exit_error "Failed to install Oh My Zsh."
        }
        
        print_message "info" "Oh My Zsh installation completed."
    else
        print_message "info" "Oh My Zsh is already installed."
    fi
}

# Step 3: Backup and install dotfiles
backup_and_install_dotfiles() {
    print_message "info" "Backing up and installing dotfiles..."
    
    # Create backup directory with timestamp
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_dir="$HOME/.dotfiles_backup_${timestamp}"
    mkdir -p "$backup_dir"
    print_message "info" "Created backup directory: $backup_dir"
    
    # Define dotfiles to install
    local dotfiles=(".gitconfig" ".vimrc" ".zshrc" ".lesshst")
    
    for file in "${dotfiles[@]}"; do
        # Check if source file exists in repository
        if [ ! -f "$SCRIPT_DIR/$file" ]; then
            print_message "warn" "Source file $file not found in repository, skipping."
            continue
        fi
        
        # Backup existing file if it exists
        if [ -f "$HOME/$file" ]; then
            print_message "info" "Backing up existing $file..."
            cp "$HOME/$file" "$backup_dir/" || {
                print_message "warn" "Failed to backup $file, but continuing..."
            }
        fi
        
        # Copy the file from repository to home directory
        print_message "info" "Installing $file to $HOME/$file..."
        cp "$SCRIPT_DIR/$file" "$HOME/$file" || {
            exit_error "Failed to install $file."
        }
    done
    
    print_message "info" "Dotfiles installation completed."
}

# Step 4: Install custom theme
install_theme() {
    print_message "info" "Installing custom theme..."
    
    local theme_source="$SCRIPT_DIR/themes/molayab.zsh-theme"
    local theme_dest="$HOME/.oh-my-zsh/themes/molayab.zsh-theme"
    
    if [ ! -f "$theme_source" ]; then
        exit_error "Theme file $theme_source not found!"
    fi
    
    cp "$theme_source" "$theme_dest" || {
        exit_error "Failed to install custom theme."
    }
    
    print_message "info" "Custom theme installed successfully."
    
    # Set the theme in .zshrc if not already set
    if ! grep -q 'ZSH_THEME="molayab"' "$HOME/.zshrc"; then
        print_message "info" "Setting molayab as the default theme..."
        sed -i.bak 's/^ZSH_THEME=.*$/ZSH_THEME="molayab"/' "$HOME/.zshrc" || {
            print_message "warn" "Failed to set theme in .zshrc. Please set it manually."
        }
    else
        print_message "info" "Theme is already configured in .zshrc."
    fi
}

# Step 6: Source configuration and display success message
finalize_installation() {
    print_message "info" "Finalizing installation..."
    
    # Change default shell to Zsh if it's not already
    if [ "$SHELL" != "$(which zsh)" ]; then
        print_message "info" "Setting Zsh as default shell..."
        chsh -s "$(which zsh)" || {
            print_message "warn" "Failed to set Zsh as default shell. Please do it manually."
        }
    fi
    
    echo -e "\n${GREEN}=====================================${NC}"
    echo -e "${GREEN}    Dotfiles Installation Complete    ${NC}"
    echo -e "${GREEN}=====================================${NC}\n"
    
    echo -e "Your dotfiles have been successfully installed!"
    echo -e "Any existing configuration files were backed up before being replaced."
    echo
    echo -e "${YELLOW}Next Steps:${NC}"
    echo -e "1. Start a new terminal session or run: ${BLUE}source ~/.zshrc${NC}"
    echo -e "2. Verify that your theme and plugins are working correctly"
    echo
    echo -e "If you encounter any issues, you can find your backups in the backup directory."
    echo -e "Enjoy your new shell environment! 🎉"
}

# Main execution
main() {
    # Execute all steps
    check_zsh
    check_oh_my_zsh
    backup_and_install_dotfiles
    install_theme
    finalize_installation
}

# Run the script
main

