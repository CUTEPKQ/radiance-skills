---
name: handoff
description: Compact this session into a handoff.md at the project root so the next session can pick the work up.
argument-hint: "What will the next session focus on?"
disable-model-invocation: true
---

# Handoff

Compact the current session into a handoff document at **`handoff.md` in the current project root**, so a fresh session — a new conversation, a different model, or you tomorrow — can resume the work without replaying the transcript.

## Rules

1. **This session only. Overwrite the whole file; never append.**
   If `handoff.md` already exists, read it first — but only to work out which of the previous session's open items got closed in this one — then **rewrite it end to end**. Do not carry the previous session's log forward. The document always describes the *current* state, not a history.
2. **Reference, don't duplicate.**
   Anything already captured in code, commits, issues, experiment logs, or notes gets a path / URL / commit hash — never a copy.
3. **Separate verified from unverified.**
   Anything you ran and observed is verified. Inferences, expectations, and things not yet run are labelled as assumptions. Never write a guess in the voice of a result.
4. **Record failures and skips honestly.**
   Approaches that didn't work, work abandoned midway, parts deliberately skipped — all of it, with the reason. This is the highest-value content in the document: it stops the next session repeating dead ends.
5. **Redact secrets.**
   Strip API keys, tokens, passwords, and personal information in paths before writing.
6. **Arguments set the focus.**
   If the user passed arguments, treat them as what the next session is for, and weight the document accordingly — compress everything unrelated to a line or two.

## Structure

Use exactly these three sections, in this order.

### 1. Done this session / resolved

- What was actually touched: what changed, what ran, what came out.
- Which open items from the previous session were closed, and how.
- **Every claim carries its evidence** — a metric, an error that stopped firing, a diff path. "Fixed it" with nothing behind it is worthless to the next session.

### 2. Open / in progress

- Running but not finished: where it runs, how to read the result, roughly when it lands.
- Stuck: the symptom, what's already been ruled out, what to try next.
- Hypotheses raised this session but not yet tested.

Tag every item with its state: `in progress` / `blocked` / `needs verification` / `parked (reason)`.

### 3. Reference

- **Relevant files** — key paths touched or read this session, each with one line on what it does. Mark the ones that changed.
- **Repro / experiment commands** — complete, copy-pasteable command lines for training, evaluation, and debug scripts, including config paths, checkpoint paths, hyperparameter overrides, and any required environment variables. Never write something unrunnable like "run the training script".
- **External links** — experiment tracking runs, issues, arXiv links, relevant commit hashes.

## Language

Write in the language of the conversation (Chinese by default). Keep technical terms in English — do not translate them.
