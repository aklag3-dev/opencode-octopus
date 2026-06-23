# Task Force Recommendations

## Problem
Octopus v1-v2 relies on prose-based delegation. The Manager asks agents to "please not build" rather than enforcing constraints at the tool level.

## 10 Recommendations

### 1. Tool-Level Enforcement (Dario Amodei)
Replace prose scope boundaries with tool allowlists. If the Researcher lacks Write, it cannot write.

### 2. Cold Verification (Sam Altman)
A separate verifier with independent context beats self-critique every time. The builder's context is compromised by intent.

### 3. Schema-Typed Handoffs (Andrej Karpathy)
Every agent output has a defined schema. Handoffs are validated before the next agent receives them.

### 4. STOP Gates (Patrick Collison)
Before any irreversible action, the pipeline halts and writes to PENDING-APPROVALS.md. Human clears before proceeding.

### 5. Worktree Isolation (Tom Brown)
The Maker runs in a git worktree. In-progress builds cannot corrupt the main branch.

### 6. Model Routing per Stage (OpenAI)
Haiku for research fan-out (fast, cheap), Sonnet for design/build, Opus only for orchestration apex. Cuts cost ~75%.

### 7. No Autonomous Distribution (Security WG)
The Marketer drafts; a human sends. This is a permanent architectural gate, not a configurable setting.

### 8. Security Pass in Every Gate (Google)
Secret scan + dependency audit run before any deploy. Non-disableable, non-overridable.

### 9. Plugin Packaging (Claude Code Team)
Octopus installs as a plugin under ~/.claude/plugins/. Never touches CLAUDE.md, settings.json, or existing config.

### 10. Falsifiable Evaluation Criteria (Five Innovators Lab)
Every evaluation produces a falsifiable recommendation: KILL, PIVOT, or SCALE. No "maybe" or "let's wait and see."
