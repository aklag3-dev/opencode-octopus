# 🐙 Octopus: Multi-Agent Orchestration OS for OpenCode

**Five agents. One orchestrator. Ship anything.**

Octopus turns [OpenCode](https://opencode.ai) into a five-agent team. You are the **Purple Manager** - you decompose tasks, dispatch specialist agents, enforce quality gates between stages, and synthesise results.

```
   ___   ____ _____ ___  ____  _   _ ____
  / _ \ / ___|_   _/ _ \|  _ \| | | / ___|
 | | | | |     | || | | | |_) | | | \___ \
 | |_| | |___  | || |_| |  __/| |_| |___) |
  \___/ \____| |_| \___/|_|    \___/|____/

  Multi-Agent Orchestration OS  +  OpenCode
```

## The Five Agents

| Color | Agent | Role | Domain |
|-------|-------|------|--------|
| 🟡 **Yellow** | Researcher & Analyst | Intelligence | Market research, competitor analysis, data synthesis, evaluation |
| 🟠 **Red-Orange** | Designer | Solutions | UX/UI, system architecture, wireframes, design specs |
| 🔵 **Blue** | Maker | Building | Code, infrastructure, deployment, testing |
| 🟢 **Green** | Marketer | Distribution | Copywriting, SEO, campaigns, growth |
| 🟣 **Purple** | Manager | Orchestration | Planning, delegation, quality gates, synthesis |

## Features

- **Contract-first delegation** — Every agent gets success criteria, scope, output format, and escalation triggers before starting
- **Three orchestration modes** — Sequential pipelines, parallel fan-outs, review loops. Mix and match
- **Quality gates** — Enforced checks between every stage (Research→Design→Build→Deploy→Market→Evaluate)
- **Filesystem ground truth** — All outputs written to disk. Status files prevent loading incomplete work
- **Venture metaskill** — Discover micro-tool opportunities, build, launch, and evaluate with hunt/harvest modes
- **Tool-level enforcement** — Each agent has exactly the tools it needs. Tool allowlists are the enforcement layer

## Quick Start

### Option A: Terminal Command

Install `octopus` as a global command. Works from any directory.

```bash
git clone https://github.com/anomalyco/opencode-octopus
cd opencode-octopus && bash install.sh
source ~/.zshrc
octopus
```

The installer copies files to `~/.config/opencode/octopus/` and appends a shell function to your shell config. Nothing else is touched.

### Option B: Project Mode

Clone and open directly with OpenCode. `OPENER.md` loads automatically.

```bash
git clone https://github.com/anomalyco/opencode-octopus
cd opencode-octopus && opencode
```

### Option C: Any LLM Terminal

Add `octopus.md` to your system prompt or project context. Works with Claude Code, Codex CLI, Gemini CLI, or any terminal with tool use.

```json
// In your opencode.json:
{
  "instructions": ["octopus.md"]
}
```

## Commands

| Command | What Happens |
|---------|-------------|
| `research [topic]` | Spawn Yellow Researcher (Scout mode) |
| `evaluate [target]` | Spawn Yellow Analyst (Evaluate mode) |
| `design [brief]` | Spawn Red-Orange Designer |
| `build [spec]` | Spawn Blue Maker |
| `market [product]` | Spawn Green Marketer |
| `sprint [goal]` | Full pipeline: research → design → build → market |
| `team [tasks]` | Parallel fan-out to multiple agents |
| `review [work]` | Review loop between two agents |
| `help` | Show available commands and agent types |
| `cycle hunt [niche]` | Venture: discover and launch a micro-tool |
| `cycle harvest [product]` | Venture: compound a winning product |
| `cycle status` | Venture: check all active products |

## Orchestration Modes

### Sequential Pipeline
```
Agent A → Agent B → Agent C
```
Each stage takes the previous stage's output as input. Use when work is dependent.

### Parallel Fan-out
```
Manager → [Agent A, Agent B, Agent C] → Manager synthesises
```
Independent tasks run simultaneously. Use for speed.

### Review Loop
```
Builder → Reviewer → Builder → ... (max 5 rounds)
```
Iterative refinement between two agents. Use for quality.

## Project Structure

```
opencode-octopus/
├── opencode.json           # OpenCode project config
├── OPENER.md               # Purple Manager system prompt
├── AGENTS.md               # Agent registry
├── octopus.md              # Portable system prompt (any terminal)
├── install.sh              # Terminal command installer
├── uninstall.sh            # Clean uninstaller
├── index.html              # GitHub Pages landing page
├── .opencode/
│   ├── agents/             # Agent definitions for OpenCode
│   │   ├── researcher.md
│   │   ├── designer.md
│   │   ├── maker.md
│   │   ├── marketer.md
│   │   └── manager.md
│   └── commands/           # Command definitions for OpenCode
│       ├── research.md
│       ├── evaluate.md
│       ├── design.md
│       ├── build.md
│       ├── market.md
│       ├── sprint.md
│       ├── team.md
│       ├── review.md
│       └── help.md
├── octopus-team/           # Multi-terminal tmux mode
│   ├── README.md
│   ├── install-team.sh
│   ├── octopus-team-banner.sh
│   └── orchestrate.sh
├── metaskills/
│   └── venture/            # Venture metaskill (hunt/harvest)
│       ├── README.md
│       ├── product-types.md
│       ├── hunt-mode.md
│       ├── harvest-mode.md
│       └── spawn-templates.md
├── octopus-vision.md       # Full vision paper
├── octopus-vision-generic.md # Platform-agnostic vision
├── octopus-banner.sh       # 5-color ASCII banner
├── PROPOSED-CHANGES.md     # Proposed improvements
├── TASK-FORCE-RECOMMENDATIONS.md
└── site.webmanifest
```

## Quality Gates

| Gate | Check |
|------|-------|
| Research → Design | Brief complete, sources verified, opportunity validated |
| Design → Build | Spec unambiguous, scope bounded, dependencies identified |
| Build → Deploy | Tests pass, code secure, no hardcoded secrets |
| Deploy → Distribute | Live URL returns HTTP 200, smoke test passed |
| Distribute → Evaluate | Distribution assets deployed, channels documented |
| Evaluate → Decision | Metrics collected, KILL/PIVOT/SCALE delivered with evidence |

## Safety

- **No global installation** — Installs under `~/.config/opencode/octopus/`. Never touches your config
- **Least privilege** — Each agent has exactly the tools it needs
- **No autonomous distribution** — Marketer drafts; a human sends. Permanent architectural gate
- **No settings.json, no hooks, no config overrides**

## Uninstall

```bash
# Remove the # >>> octopus-opencode >>> block from ~/.zshrc (or ~/.bashrc)
bash uninstall.sh
source ~/.zshrc
```

## Architecture

Octopus is a prompt-based orchestration framework. The system prompt (`octopus.md` or `OPENER.md`) instructs the AI to act as a Purple Manager who delegates to specialist subagents. Coordination happens through:

- **Structured spawn templates** - Copy-paste prompts for dispatching each agent type
- **Handoff documents** - Standardised format for passing work between agents
- **Filesystem state** - `.octopus/` directory for state tracking and artefacts
- **Quality gates** - Explicit checks at every pipeline transition

The framework is platform-agnostic and works with any AI coding terminal that supports tool use and subagent dispatch.

## Credits

Based on [Octopus v3](https://github.com/victordelrosal/octopus) by [Victor del Rosal](https://victordelrosal.com) / [fiveinnolabs](https://fiveinnolabs.com). Built on frameworks from Google DeepMind (Intelligent AI Delegation), Claude Code (Agent Teams), and the Five Innovators model. Adapted for [OpenCode](https://opencode.ai).

## License

Open. Use it to ship faster.
