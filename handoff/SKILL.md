---
name: handoff
description: Compact this session into handoff.md at the project root, and append what was tried to CHANGELOG.md.
argument-hint: "What will the next session focus on?"
disable-model-invocation: true
---

# Handoff

Two documents, with deliberately opposite lifetimes:

- **`handoff.md`** — the *current state*. Rewritten from scratch every time, carries no history.
- **`CHANGELOG.md`** — the *history*. Appended to, never rewritten. This is where everything `handoff.md` throws away is preserved.

Both go at the project root unless the project's `CLAUDE.md` says otherwise. Write `handoff.md` first, then derive the CHANGELOG entries from the same material.

## Rules for both

1. **Reference, don't duplicate.** Anything already captured in code, commits, issues, experiment logs, or notes gets a path / URL / commit hash — never a copy.
2. **Separate verified from unverified.** Anything you ran and observed is verified. Inferences, expectations, and things not yet run are labelled as assumptions. Never write a guess in the voice of a result.
3. **Record failures and skips honestly.** Approaches that didn't work, work abandoned midway, parts deliberately skipped — all of it, with the reason. This is the highest-value content in both files: it stops the next session repeating dead ends.
4. **Redact secrets.** Strip API keys, tokens, passwords, and personal information in paths before writing.
5. **Get the real date** by running `date +%F`. Never guess it.
6. **Arguments set the focus.** If the user passed arguments, treat them as what the next session is for, and weight `handoff.md` accordingly — compress everything unrelated to a line or two.

---

## Part 1 — `handoff.md` (overwrite)

**This session only. Overwrite the whole file; never append.** If `handoff.md` already exists, read it first — but only to work out which of the previous session's open items got closed in this one — then **rewrite it end to end**. Do not carry the previous session's log forward. The document always describes the *current* state, not a history.

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
- **Repro / experiment commands** — complete, copy-pasteable command lines for training, evaluation, and debug scripts, including config paths, checkpoint paths, hyperparameter overrides, and any required environment variables. Never write something unrunnable like "run the training script". If the project's `CLAUDE.md` records the launch commands, build on those rather than reinventing them.
- **External links** — experiment tracking runs, issues, arXiv links, relevant commit hashes.

---

## Part 2 — `CHANGELOG.md` (append)

The permanent record of what was tried and what came of it.

- **One entry per experiment or method exploration — not one per session.** A session that ran three configs gets three entries. A session that only refactored the data loader gets none.
- **Skip it entirely when nothing was tried.** Never manufacture an entry just to have written something.
- **Never modify or delete an existing entry.** A failed experiment stays on the record permanently — that is the whole point of the file. The one permitted edit is correcting a factual error, and it must be marked as a correction.
- **If the file doesn't exist**, create it with a `# Changelog` header and a line noting that entries are newest-first.
- **Insert new entries directly below the header**, newest first.

Entry format:

```markdown
## YYYY-MM-DD — <short title of what was tried>

- **Question / hypothesis** — what this was meant to settle.
- **What was done** — the change or config, concretely. Point at the commit or config path rather than pasting it.
- **Result** — numbers, and the baseline they are compared against. If it didn't finish, say so and why.
- **Verdict** — `works` / `doesn't work` / `inconclusive`, plus one line of why.
- **Follow-up** — what this opens up, or what it now rules out.
```

If the experiment changed the method itself, run the `design` skill to update `Design.md`, and cross-link the two.

## Language

Write in the language of the conversation (Chinese by default). Keep technical terms in English — do not translate them.
