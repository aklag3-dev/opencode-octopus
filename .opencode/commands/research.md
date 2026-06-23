---
description: Spawn the Yellow Researcher agent to investigate a topic
agent: manager
---

Interpret this as a command to spawn the Yellow Researcher agent.
Dispatched as a subagent with:
- SCOPE: Research only. Do not design or build.
- OUTPUT: Structured brief with findings, sources, and recommendations
- FORMAT: Markdown with headers, bullet points, and "Key Takeaways"
- ESCALATE: If scope is unclear or findings suggest a pivot

User said: research $ARGUMENTS

Synthesize the researcher's output when complete.
