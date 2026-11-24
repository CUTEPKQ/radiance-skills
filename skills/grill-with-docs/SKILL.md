---
name: grill-with-docs
description: Grill a design until it settles, patching Design.md and writing ADRs inline as decisions land.
argument-hint: "What design are we deciding?"
disable-model-invocation: true
---

# Grill with Docs

Call the Skill tool with "grill-me" and run the interview. On top of it, keep the project's design docs current as decisions land, not at the end. Paths are the defaults; `CLAUDE.md` may override them.

## Before and during each round

- **Bring the evidence.** Before putting a question, check `docs/experiments/` and `docs/adr/` for what already settles or bears on it, and cite it in the question. Never re-open an accepted ADR without new evidence; when there is some, say which ADR it challenges.
- **Challenge against `Design.md`.** When the user's description conflicts with a stage, a convention, or a shape in `Design.md`, call it out at once: "Design.md says latents are `(B, T, C, H, W)`, you're describing `(B, C, T, H, W)`. Which is it?"
- **Cross-reference the code.** When the user states how something works, check the code. Surface contradictions; where `Design.md` and code disagree, the code wins.
- **Stress-test with scenarios.** Invent concrete edge cases (sequence shorter than the context window, an all-masked batch, a different resolution at eval) that force the boundaries of the design to be explicit.

## Write as decisions land

- **`Design.md`**: patch the affected section in place, following its existing structure. If it doesn't exist, create it lazily when the first decision lands, with only the sections that decision needs (Motivation, and the Pipeline stages it touches). Tag anything not yet built `planned`. Current state only: the reasoning goes in the ADR, not here.
- **`docs/adr/NNNN-<slug>.md`**: write one only when the decision is all three: hard to reverse, surprising without context, and the result of a real trade-off. Number it one above the highest in `docs/adr/`; create the directory lazily. Never rewrite an accepted ADR's reasoning; when a new one replaces it, set the old one's status to `superseded by NNNN`.

```markdown
# NNNN: <decision>

**Status:** accepted
<1-3 sentences: the context, what was decided, and why. Cite the experiment file or paper that backs it.>
**Would overturn it:** the evidence that would reopen this.
```

Add **Alternatives** only when a rejection is non-obvious enough that someone would suggest it again.
