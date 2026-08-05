---
name: design
description: Create or update Design.md — how the method's pipeline is built, stage by stage.
argument-hint: "What changed in the design?"
disable-model-invocation: true
---

# Design

Maintain **`Design.md`**: the design of the pipeline and **how each stage is implemented**, as it stands right now. Complete enough that someone could reimplement the method from this document alone — and detailed enough that reading it beats reading the code when you want to know how a stage works.

It goes at the project root unless the project's `CLAUDE.md` says otherwise.

## Rules

1. **Current state only. Update in place.**
   No "previously we did X", no changelog at the bottom. Superseded designs belong in `CHANGELOG.md`. If a design change is worth remembering, append the reason there and leave `Design.md` describing only what is true now.
2. **Read it first, then patch what the change touches.**
   Never regenerate the whole document — that quietly drops detail nobody thought to restate.
3. **Describe the mechanism, don't paste the code.**
   Write the algorithm: the steps, the formulas, the transformations, the branching. Someone who wants the literal code follows the path you cited. A stage described only as "handles the encoding" is a failure — say *how* it encodes.
4. **Ground every claim in the code.**
   Every stage cites the file and symbol implementing it, as `path/to/file.py:ClassOrFunction`. Where document and code disagree, the code wins — fix the document. If you cannot find code for something, say so instead of documenting it as if it exists.
5. **Implemented and planned are different things.** Tag anything not yet built as `planned`. A reader must never mistake an intention for working code.
6. **Shapes everywhere.** Every tensor crossing a stage boundary gets its shape, dtype, and value range or convention.
7. **Arguments are the change to fold in.** If the user passed arguments, treat them as the design change being recorded.

## Structure

### 1. Overview

A short paragraph — what the method does and what counts as success (which metric, which benchmark, which baseline) — then a diagram of the flow (mermaid or ASCII). The diagram is the map the rest of the document hangs off.

### 2. Global conventions

The things every stage must agree on, and where cross-stage bugs come from: data layout and axis order, coordinate system, normalization convention, time / frame indexing, padding and masking, dtype and device policy. Short, but state it explicitly — a convention that lives only in people's heads is the one that silently breaks.

### 3. Pipeline

The body of the document. One subsection per stage, walking the flow end to end — data → model → training → inference / evaluation. Split a stage further whenever a sub-part has its own non-obvious mechanism.

For each stage:

- **Purpose** — one line: what it is responsible for.
- **In → out** — every tensor, with shape, dtype, and value range or convention.
- **How it works** — the mechanism, in enough detail to reimplement: the steps in order, the formulas or losses, what is learned versus fixed, the branching and special cases. This is the part that matters most; give it the most room.
- **Where** — `path/to/file.py:ClassOrFunction` for the implementation, plus the config that drives it.
- **Hyperparameters** — the ones that matter, each tagged with its origin: `paper default` / `empirical` / `arbitrary`.
- **Why this way** — the design choice behind this stage, what was rejected, and what evidence would overturn it. Link the `CHANGELOG.md` entry or paper backing it. Skip this line when the stage is a standard, unremarkable implementation — don't manufacture rationale.
- **Assumptions** — what this stage requires of its input, and what downstream stages may rely on from its output.

### 4. Known limitations / unverified

What is known broken, what is assumed but never measured, what is deliberately out of scope. Anything here that later gets tested graduates into a `CHANGELOG.md` entry.

## Language

Write in the language of the conversation (Chinese by default). Keep technical terms in English — do not translate them.
