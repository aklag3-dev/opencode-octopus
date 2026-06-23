# Proposed Changes

## 1. Synthesis-Before-Delegation
Before dispatching the next stage, the Manager must produce a Stage Synthesis proving it understood the previous output. Never relay outputs blindly.

## 2. Inherited Context
Each spawn template should include an "Inherited Context" section that the Manager fills before dispatching: mission, constraints, decisions already made.

## 3. Risk Protocol
Colour-code actions by reversibility: Green (autonomous), Yellow (Manager approval), Red (human approval). Encode in agent system prompts.

## 4. Cache-Aware Context Ordering
Order content from most stable to most volatile: identity > project context > task. Maximises prompt cache hits across agent spawns.

## 5. Completion Notification Contract
Every subagent writes a status.json as its final act. The Manager reads status.json first, then reads output files. Prevents loading incomplete results.

## 6. Tool Boundary Enforcement
Define per-agent tool allowlists as the enforcement layer (not prose). If the Researcher lacks the Write tool, it cannot write, regardless of what the prompt says.
