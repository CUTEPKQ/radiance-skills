---
name: design
description: Create or update Design.md — the motivation, and the pipeline stage by stage.
argument-hint: "What changed in the design?"
disable-model-invocation: true
---

# Design

Maintain **`Design.md`** at the project root.

- **Current state only.** No history section — the reasoning behind a design and the designs it replaced live in `docs/adr/`.

## Structure

**1. Motivation** — the problem, where existing methods fall short, and the core idea that closes the gap. What counts as success: metric, benchmark, baseline.

**2. Pipeline** — open with the end-to-end input → output and a diagram of the flow. Then one subsection per stage in data-flow order (data → model → training → inference/eval), split further where a sub-part has its own non-obvious mechanism. Per stage:

- **Purpose** — one line.
- **In → out** — every tensor with shape, dtype, value range.
- **Flow** — steps in order, formulas and losses, learned vs fixed, branching and special cases. Give this the most room.
- **Why this way** — what was rejected, what would overturn it, linked to its ADR, experiment file or paper. Skip for unremarkable stages; don't manufacture rationale.
