---
name: design
description: Create or update Design.md — the current pipeline design of the method being built.
argument-hint: "What changed in the design?"
disable-model-invocation: true
---

# Design

Maintain **`Design.md`** — a description of the method's pipeline **as it stands right now**, complete enough that a fresh agent understands the approach without reading the code. It goes at the project root unless the project's `CLAUDE.md` says otherwise.

## Rules

1. **Current state only. Update in place.**
   `Design.md` never accumulates history — no "previously we did X", no changelog at the bottom. Superseded designs belong in `CHANGELOG.md`. If a design change is worth remembering, append the reason there and leave `Design.md` describing only what is true now.
2. **Read it first, then patch what the change touches.**
   Never regenerate the whole document from scratch — that quietly drops detail nobody thought to restate.
3. **Implemented and planned are different things.**
   Tag anything not yet built as `planned`. A reader must never mistake an intention for working code.
4. **Ground every claim in the code.**
   Each stage names the file or module implementing it. Where the document and the code disagree, the code wins — fix the document. If you cannot find the code for something the user describes, say so rather than documenting it as if it exists.
5. **Annotate tensor shapes** at every stage boundary.
6. **Record decisions, not just layout.**
   The most valuable part of this document is *why* the pipeline looks like this — including what was rejected and what would make you reconsider.
7. **Arguments are the change to fold in.** If the user passed arguments, treat them as the design change being recorded.

## Structure

### 1. Objective

One paragraph: what the method is trying to do, and what counts as success — which metric, on which benchmark, against which baseline.

### 2. Pipeline

Walk the stages end to end — data → model → training → inference / evaluation. For each stage:

- what goes in and what comes out, **with shapes**
- the file or module that implements it
- key hyperparameters, each tagged with its origin: `paper default` / `empirical` / `arbitrary`

Put a diagram (mermaid or ASCII) at the top of this section if the flow branches or loops.

### 3. Key design decisions

One entry per non-obvious choice:

- the decision
- why — the reasoning or the evidence
- what was rejected, and why it lost
- what evidence would overturn it

Link to the `CHANGELOG.md` entry or the paper that backs each one.

### 4. Known limitations / unverified

What is known broken, what is assumed but never measured, what is deliberately out of scope. Anything here that later gets tested graduates into a `CHANGELOG.md` entry.

## Language

Write in the language of the conversation (Chinese by default). Keep technical terms in English — do not translate them.
