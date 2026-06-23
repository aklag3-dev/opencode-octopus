#!/bin/bash
# Octopus Team Installer for OpenCode
# Installs the `octopus-team` command for multi-terminal mode.

set -e

PURPLE='\033[1;35m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
DIM='\033[0;90m'
RESET='\033[0m'

echo ""
echo -e "${PURPLE}  Octopus Team Installer (OpenCode Edition)${RESET}"
echo ""

# Check prerequisites
if ! command -v tmux &> /dev/null; then
  echo -e "${RED}  Error: tmux is required but not installed.${RESET}"
  echo -e "${YELLOW}  Install it with: apt install tmux (or brew install tmux)${RESET}"
  exit 1
fi

if ! command -v opencode &> /dev/null; then
  echo -e "${YELLOW}  Warning: opencode not found in PATH. Install from https://opencode.ai${RESET}"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect shell config
SHELL_CONFIG=""
if [[ -f "$HOME/.zshrc" ]]; then
  SHELL_CONFIG="$HOME/.zshrc"
elif [[ -f "$HOME/.bashrc" ]]; then
  SHELL_CONFIG="$HOME/.bashrc"
elif [[ -f "$HOME/.bash_profile" ]]; then
  SHELL_CONFIG="$HOME/.bash_profile"
else
  echo -e "${RED}  Error: No shell config file found${RESET}"
  exit 1
fi

SHELL_CONFIG_NAME=$(basename "$SHELL_CONFIG")

# Copy files
INSTALL_DIR="$HOME/.config/opencode/octopus-team"
mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_DIR/orchestrate.sh" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/orchestrate.sh"
cp "$SCRIPT_DIR/octopus-team-banner.sh" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/octopus-team-banner.sh"

echo -e "${BLUE}  [1/2]${RESET} Files copied to $INSTALL_DIR"

# Add shell function
MARKER="# >>> octopus-team >>>"
if grep -qF "$MARKER" "$SHELL_CONFIG" 2>/dev/null; then
  echo -e "${YELLOW}  Already present in $SHELL_CONFIG_NAME (skipping)${RESET}"
else
  cat >> "$SHELL_CONFIG" << 'SHELL_BLOCK'

# >>> octopus-team >>>
# Octopus Team - Multi-Terminal Multi-Agent Orchestration
octopus-team() {
  if [[ -f "$HOME/.config/opencode/octopus-team/octopus-team-banner.sh" ]]; then
    bash "$HOME/.config/opencode/octopus-team/octopus-team-banner.sh"
  fi

  local goal="$*"
  if [[ -z "$goal" ]]; then
    echo "Usage: octopus-team <goal>"
    echo "Example: octopus-team build a landing page for my SaaS"
    return 1
  fi

  bash "$HOME/.config/opencode/octopus-team/orchestrate.sh" "$goal"
}
# <<< octopus-team <<<
SHELL_BLOCK
  echo -e "${GREEN}  [2/2]${RESET} Added octopus-team() to $SHELL_CONFIG_NAME"
fi

echo ""
echo -e "${GREEN}  Done!${RESET}"
echo -e "  Run: ${PURPLE}source $SHELL_CONFIG_NAME${RESET}"
echo -e "  Then: ${PURPLE}octopus-team <goal>${RESET}"
echo ""
