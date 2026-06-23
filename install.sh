#!/bin/bash
# Octopus Installer for OpenCode
# Installs the `octopus` terminal command for OpenCode.
# Safe: idempotent, append-only, never touches existing config.

set -e

# Colors
PURPLE='\033[1;35m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
DIM='\033[0;90m'
RESET='\033[0m'

echo ""
echo -e "${PURPLE}  Octopus Installer (OpenCode Edition)${RESET}"
echo -e "${PURPLE}  Multi-Agent Orchestration OS${RESET}"
echo ""

# Resolve script directory
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
  echo -e "${RED}  Error: No shell config file found (.zshrc, .bashrc, .bash_profile)${RESET}"
  exit 1
fi

SHELL_CONFIG_NAME=$(basename "$SHELL_CONFIG")
echo -e "${DIM}  Detected shell config: $SHELL_CONFIG${RESET}"

# Verify required files exist
if [[ ! -f "$SCRIPT_DIR/octopus-banner.sh" ]]; then
  echo -e "${RED}  Error: octopus-banner.sh not found in $SCRIPT_DIR${RESET}"
  exit 1
fi

if [[ ! -f "$SCRIPT_DIR/octopus.md" ]]; then
  echo -e "${RED}  Error: octopus.md not found in $SCRIPT_DIR${RESET}"
  exit 1
fi

# Step 1: Ensure install directory exists
INSTALL_DIR="$HOME/.config/opencode/octopus"
echo -e "${BLUE}  [1/4]${RESET} Copying files to $INSTALL_DIR/"
mkdir -p "$INSTALL_DIR"

cp "$SCRIPT_DIR/octopus-banner.sh" "$INSTALL_DIR/octopus-banner.sh"
chmod +x "$INSTALL_DIR/octopus-banner.sh"
echo -e "${DIM}        $INSTALL_DIR/octopus-banner.sh${RESET}"

cp "$SCRIPT_DIR/octopus.md" "$INSTALL_DIR/octopus.md"
echo -e "${DIM}        $INSTALL_DIR/octopus.md${RESET}"

# Copy OPENER.md (project policy)
cp "$SCRIPT_DIR/OPENER.md" "$INSTALL_DIR/OPENER.md"
echo -e "${DIM}        $INSTALL_DIR/OPENER.md${RESET}"

# Copy agent definitions
if [[ -d "$SCRIPT_DIR/.opencode/agents" ]]; then
  mkdir -p "$INSTALL_DIR/agents"
  cp "$SCRIPT_DIR/.opencode/agents/"*.md "$INSTALL_DIR/agents/"
  echo -e "${DIM}        $INSTALL_DIR/agents/ (5 files)${RESET}"
fi

# Copy venture metaskill (if present)
if [[ -d "$SCRIPT_DIR/metaskills/venture" ]]; then
  mkdir -p "$INSTALL_DIR/venture"
  cp "$SCRIPT_DIR/metaskills/venture/"*.md "$INSTALL_DIR/venture/"
  echo -e "${DIM}        $INSTALL_DIR/venture/ (5 files)${RESET}"
fi

# Step 2: Append octopus() function to shell config (guarded)
echo -e "${BLUE}  [2/4]${RESET} Adding octopus() to $SHELL_CONFIG_NAME"

MARKER="# >>> octopus-opencode >>>"
if grep -qF "$MARKER" "$SHELL_CONFIG" 2>/dev/null; then
  echo -e "${YELLOW}        Already present in $SHELL_CONFIG_NAME (skipping)${RESET}"
  echo -e "${DIM}        To update, remove the octopus block from $SHELL_CONFIG_NAME and re-run.${RESET}"
else
  cat >> "$SHELL_CONFIG" << 'SHELL_BLOCK'

# >>> octopus-opencode >>>
# Octopus - Multi-Agent Orchestration OS for OpenCode
# https://github.com/anomalyco/opencode-octopus
octopus() {
  # Show the 5-color ASCII banner
  if [[ -f "$HOME/.config/opencode/octopus/octopus-banner.sh" ]]; then
    bash "$HOME/.config/opencode/octopus/octopus-banner.sh"
  fi

  # Launch OpenCode — global config at ~/.config/opencode/opencode.json
  # loads OPENER.md as instructions and registers all 5 agents
  opencode "$@"
}
# <<< octopus-opencode <<<
SHELL_BLOCK
  echo -e "${GREEN}        Added to $SHELL_CONFIG_NAME${RESET}"
fi

# Step 3: Install global opencode.json config
echo -e "${BLUE}  [3/4]${RESET} Installing global opencode config"

GLOBAL_CONFIG="$HOME/.config/opencode/opencode.json"
if [[ -f "$GLOBAL_CONFIG" ]]; then
  echo -e "${YELLOW}        $GLOBAL_CONFIG already exists (skipping)${RESET}"
  echo -e "${DIM}        To configure manually, add to your opencode.json:${RESET}"
  echo -e "${DIM}        { \"instructions\": [\"~/.config/opencode/octopus/OPENER.md\"], \"agent\": { ... } }${RESET}"
else
  cat > "$GLOBAL_CONFIG" << 'GLOBAL'
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": ["~/.config/opencode/octopus/OPENER.md"],
  "agent": {
    "researcher": {
      "description": "Yellow Researcher & Analyst — intelligence gathering, analysis, evaluation",
      "mode": "subagent",
      "permission": { "read": "allow", "glob": "allow", "grep": "allow", "webfetch": "allow", "websearch": "allow", "bash": { "grep *": "allow", "find *": "allow", "curl *": "allow", "*": "deny" }, "edit": "deny" }
    },
    "designer": {
      "description": "Red-Orange Designer — solutions, architecture, wireframes, design specs",
      "mode": "subagent",
      "permission": { "read": "allow", "glob": "allow", "grep": "allow", "write": "allow", "edit": "allow", "bash": "deny" }
    },
    "maker": {
      "description": "Blue Maker — code, infrastructure, deployment, testing",
      "mode": "subagent",
      "permission": { "read": "allow", "glob": "allow", "grep": "allow", "write": "allow", "edit": "allow", "bash": { "npm *": "allow", "git *": "allow", "node *": "allow", "python *": "allow", "mkdir *": "allow", "cp *": "allow", "mv *": "allow", "rm *": "allow", "*": "ask" } }
    },
    "marketer": {
      "description": "Green Marketer — copywriting, campaigns, growth assets, distribution drafts",
      "mode": "subagent",
      "permission": { "read": "allow", "write": "allow", "edit": "allow", "websearch": "allow", "bash": "deny" }
    },
    "manager": {
      "description": "Purple Manager (the Octopus) — orchestrates agents, enforces quality gates, synthesizes results",
      "mode": "all",
      "permission": { "read": "allow", "glob": "allow", "grep": "allow", "write": "allow", "edit": "allow", "bash": "allow", "webfetch": "allow", "websearch": "allow", "task": "allow" }
    }
  }
}
GLOBAL
  echo -e "${GREEN}        Created $GLOBAL_CONFIG${RESET}"
fi

# Step 4: Done
echo -e "${BLUE}  [4/4]${RESET} Verifying installation"
echo ""
echo -e "${GREEN}  Done! Octopus for OpenCode is installed.${RESET}"
echo ""
echo -e "  ${YELLOW}Next steps:${RESET}"
echo -e "    1. Run: ${PURPLE}source $SHELL_CONFIG_NAME${RESET}"
echo -e "    2. Type: ${PURPLE}octopus${RESET} from any directory"
echo ""
echo -e "  ${YELLOW}Usage:${RESET}"
echo -e "    ${DIM}octopus${RESET}            Launch OpenCode with Octopus system prompt"
echo ""
echo -e "  ${YELLOW}Uninstall:${RESET}"
echo -e "    1. Remove the ${DIM}# >>> octopus-opencode >>>${RESET} block from $SHELL_CONFIG_NAME"
echo -e "    2. Run: ${DIM}bash $SCRIPT_DIR/uninstall.sh${RESET}"
echo ""
