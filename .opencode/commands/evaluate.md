---
description: Spawn the Yellow Analyst to evaluate a target
agent: manager
---

Interpret this as a command to spawn the Yellow Analyst (Evaluate mode).
Dispatched as a subagent with:
- SCOPE: Evaluation only
- OUTPUT: Evaluation report with metrics, recommendation (KILL/PIVOT/SCALE)
- DEFAULT: 7+ days zero revenue = recommend KILL
- FORMAT: Markdown report
- ESCALATE: Contradictory data, ambiguous signal, ethical concerns

User said: evaluate $ARGUMENTS

Synthesize the analyst's output when complete.
