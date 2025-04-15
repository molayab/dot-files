# ==================== BASIC OH MY ZSH CONFIGURATION ====================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="molayab"

# ==================== ENVIRONMENT VARIABLES AND PATH ====================
export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/Users/dks0721391/.mint/bin:/Users/dks0721391/Applications:/usr/local/bin:/usr/local/jamf/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# ==================== PLUGIN CONFIGURATION ====================
plugins=(
    git 
    macos 
    dotenv 
    xcode 
    swiftpm 
    ssh 
    mosh
    brew
)
source $ZSH/oh-my-zsh.sh

# ==================== ALIASES ====================
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# ==================== FUNCTIONS ====================
# Open VS Code from terminal
code() { 
  VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
}

# Open Android Studio from terminal
studio() {
  if [ $# -eq 0 ]; then
    open -a "Android Studio" .
  else
    open -a "Android Studio" "$@"
  fi
}

# Reset Xcode workspace environment
resetWorkspaceEnvironment() {
  echo "\033[1;34m=== Resetting Xcode Workspace Environment ===\033[0m"
  
  # Initialize counters for space tracking
  local total_size_before=0
  local total_size_after=0
  
  # Calculate total space before cleaning
  echo "\033[1;33mCalculating space usage before cleaning...\033[0m"
  total_size_before=$(du -sk ~/Library/Developer 2>/dev/null | cut -f1)
  echo "Current space used: $(du -sh ~/Library/Developer 2>/dev/null | cut -f1)"

  # Clean Derived Data
  echo "\033[1;32mClearing Derived Data...\033[0m"
  if [ -d "$HOME/Library/Developer/Xcode/DerivedData" ]; then
    rm -rf "$HOME/Library/Developer/Xcode/DerivedData"/* && echo "✅ Derived Data cleared successfully"
  else
    echo "⚠️ Derived Data directory not found"
  fi

  # Clean Swift Package Manager caches
  echo "\033[1;32mClearing SwiftPM caches...\033[0m"
  if [ -d "$HOME/Library/Caches/org.swift.swiftpm" ]; then
    rm -rf "$HOME/Library/Caches/org.swift.swiftpm"/* && echo "✅ SwiftPM caches cleared successfully"
  else
    echo "⚠️ SwiftPM cache directory not found"
  fi

  # Clean Xcode module cache
  echo "\033[1;32mClearing Xcode module cache...\033[0m"
  if [ -d "$HOME/Library/Developer/Xcode/DerivedData/ModuleCache.noindex" ]; then
    rm -rf "$HOME/Library/Developer/Xcode/DerivedData/ModuleCache.noindex"/* && echo "✅ Module cache cleared successfully"
  else
    echo "⚠️ Module cache directory not found"
  fi

  # Optional: Clear iOS Device Simulators
  echo "\033[1;33mDo you want to reset iOS simulators? (y/n)\033[0m"
  read -r clean_simulators
  if [[ "$clean_simulators" =~ ^[Yy]$ ]]; then
    echo "\033[1;32mResetting iOS simulators...\033[0m"
    xcrun simctl erase all 2>/dev/null && echo "✅ iOS simulators reset successfully" || echo "⚠️ Error resetting iOS simulators"
  else
    echo "Skipping simulator reset"
  fi

  # Optional: Clear Xcode Archives
  echo "\033[1;33mDo you want to clear Xcode archives? (y/n)\033[0m"
  read -r clean_archives
  if [[ "$clean_archives" =~ ^[Yy]$ ]]; then
    echo "\033[1;32mClearing Xcode archives...\033[0m"
    if [ -d "$HOME/Library/Developer/Xcode/Archives" ]; then
      rm -rf "$HOME/Library/Developer/Xcode/Archives"/* && echo "✅ Archives cleared successfully"
    else
      echo "⚠️ Archives directory not found"
    fi
  else
    echo "Skipping archives cleanup"
  fi

  # Calculate space saved
  total_size_after=$(du -sk ~/Library/Developer 2>/dev/null | cut -f1)
  local saved_kb=$((total_size_before - total_size_after))
  local saved_mb=$((saved_kb / 1024))
  
  echo "\033[1;34m=== Cleanup Summary ===\033[0m"
  echo "Space before cleaning: $(echo "$total_size_before / 1024" | bc -l | xargs printf "%.2f") MB"
  echo "Space after cleaning: $(echo "$total_size_after / 1024" | bc -l | xargs printf "%.2f") MB"
  echo "\033[1;32mTotal space saved: $saved_mb MB\033[0m"
  
  echo "\033[1;34m=== Workspace environment reset complete! ===\033[0m"
  echo "\033[1;32mYou can now perform a clean build of your project.\033[0m"
}

# Kill Xcode-related processes
killxcodes() {
  echo "\033[1;34m=== Killing Xcode Processes ===\033[0m"
  
  # Kill all Xcode-related processes
  echo "\033[1;32mTerminating Xcode processes...\033[0m"
  pkill -9 -i "Xcode" && echo "✅ Killed Xcode application" || echo "⚠️ No Xcode application process found"
  pkill -9 -i "xcodebuildd" && echo "✅ Killed Xcode build daemon" || echo "⚠️ No Xcode build daemon found"
  pkill -9 -i "xcdeviced" && echo "✅ Killed Xcode device daemon" || echo "⚠️ No Xcode device daemon found"
  
  # Ask if user wants to kill simulators as well
  echo "\033[1;33mDo you want to kill simulator processes as well? (y/n)\033[0m"
  read -r kill_simulators
  if [[ "$kill_simulators" =~ ^[Yy]$ ]]; then
    echo "\033[1;32mTerminating simulator processes...\033[0m"
    pkill -9 -i "Simulator" && echo "✅ Killed iOS Simulators" || echo "⚠️ No simulator processes found"
    pkill -9 -i "com.apple.CoreSimulator.CoreSimulatorService" && echo "✅ Killed CoreSimulator service" || echo "⚠️ No CoreSimulator service found"
  else
    echo "Skipping simulator termination"
  fi
  
  # Ask if user wants to reset workspace environment
  echo "\033[1;33mDo you want to reset Xcode workspace environment too? (clean derived data, caches, etc.) (y/n)\033[0m"
  read -r reset_workspace
  if [[ "$reset_workspace" =~ ^[Yy]$ ]]; then
    resetWorkspaceEnvironment
  else
    echo "Skipping workspace reset"
  fi
  
  echo "\033[1;34m=== Xcode process termination complete! ===\033[0m"
}
