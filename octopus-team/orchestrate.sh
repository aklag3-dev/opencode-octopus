#!/bin/bash
# Octopus Team Orchestrator
# Creates five tmux windows with each agent running in opencode.
# Coordination happens via the .octopus/ filesystem.

set -e

GOAL="$*"
WORKSPACE=".octopus"
SESSION_NAME="octopus-team-$$"

PURPLE='\033[1;35m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RESET='\033[0m'

if [[ -z "$GOAL" ]]; then
  echo "Usage: octopus-team <goal>"
  exit 1
fi

echo -e "${PURPLE}  Octopus Team starting...${RESET}"
echo -e "${PURPLE}  Goal: $GOAL${RESET}"
echo ""

# Create workspace
mkdir -p "$WORKSPACE"/{handoffs,briefs,designs,builds,copy,state}

# Write goal to workspace
echo "$GOAL" > "$WORKSPACE/goal.txt"

# Start tmux session
tmux new-session -d -s "$SESSION_NAME" -n "manager"

# Window 1: Yellow Researcher
tmux new-window -t "$SESSION_NAME" -n "researcher" -d
tmux send-keys -t "$SESSION_NAME:researcher" "opencode --instructions <(echo 'You are the Yellow Researcher agent. Research this: $GOAL. Write output to $WORKSPACE/briefs/')" Enter

# Window 2: Red-Orange Designer
tmux new-window -t "$SESSION_NAME" -n "designer" -d
tmux send-keys -t "$SESSION_NAME:designer" "opencode --instructions <(echo 'You are the Red-Orange Designer agent. Design from research in $WORKSPACE/briefs/. Write output to $WORKSPACE/designs/')" Enter

# Window 3: Blue Maker
tmux new-window -t "$SESSION_NAME" -n "maker" -d
tmux send-keys -t "$SESSION_NAME:maker" "opencode --instructions <(echo 'You are the Blue Maker agent. Build from design in $WORKSPACE/designs/. Write output to $WORKSPACE/builds/')" Enter

# Window 4: Green Marketer
tmux new-window -t "$SESSION_NAME" -n "marketer" -d
tmux send-keys -t "$SESSION_NAME:marketer" "opencode --instructions <(echo 'You are the Green Marketer agent. Create copy and distribution for the product in $WORKSPACE/builds/. Write output to $WORKSPACE/copy/')" Enter

# Window 5: Purple Manager
tmux send-keys -t "$SESSION_NAME:manager" "echo 'Orchestrating: $GOAL'; echo 'Watch agents in other windows. Synthesize results.'" Enter

# Attach
tmux select-window -t "$SESSION_NAME:manager"
tmux attach-session -t "$SESSION_NAME"
