# Octopus Team — Multi-Terminal Mode

Run all five Octopus agents in separate tmux windows with fully isolated context. Each agent gets its own terminal, its own context window, and coordination via the filesystem.

## How It Works
- Five tmux windows: one per agent (Researcher, Designer, Maker, Marketer, Manager)
- Shared `.octopus/` workspace for handoffs
- Manager orchestrates via the shared filesystem
- Each agent reads only its assigned input and writes only to its assigned output

## Install
```bash
cd octopus-team
bash install-team.sh
source ~/.zshrc
octopus-team build a landing page for my SaaS
```

## Pipeline
1. Yellow Researcher runs first (research the domain)
2. Red-Orange Designer runs second (design from research)
3. Blue Maker + Green Marketer run in parallel (build + copy)
4. Purple Manager synthesizes all outputs

## Uninstall
1. Remove `# >>> octopus-team >>>` block from shell config
2. `rm -rf ~/.config/opencode/octopus-team/`
