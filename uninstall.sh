#!/bin/bash
# Octopus Uninstaller for OpenCode
# Removes all installed files. Safe: idempotent.

set -e

PURPLE='\033[1;35m'
GREEN='\033[1;32m'
RED='\033[1;31m'
DIM='\033[0;90m'
RESET='\033[0m'

echo ""
echo -e "${PURPLE}  Octopus Uninstaller (OpenCode Edition)${RESET}"
echo ""

INSTALL_DIR="$HOME/.config/opencode/octopus"

# Remove installed directory
if [[ -d "$INSTALL_DIR" ]]; then
  rm -rf "$INSTALL_DIR"
  echo -e "${GREEN}  Removed: $INSTALL_DIR${RESET}"
else
  echo -e "${DIM}  Not found: $INSTALL_DIR (skipping)${RESET}"
fi

echo ""
echo -e "  ${YELLOW}Remaining cleanup:${RESET}"
echo -e "    1. Remove the ${DIM}# >>> octopus-opencode >>>${RESET} block from your shell config"
echo -e "    2. Restart your shell or run ${DIM}source ~/.zshrc${RESET} (or ~/.bashrc)"
echo ""
