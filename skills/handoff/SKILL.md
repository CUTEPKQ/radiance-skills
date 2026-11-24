---
name: handoff
description: Compact this session into handoff.md, and file what it settled into the experiment docs and PITFALLS.md.
argument-hint: "What will the next session focus on?"
disable-model-invocation: true
---

# Handoff

Paths below are the defaults; `CLAUDE.md` may override them. For every document: cite paths and commit hashes instead of copying content; label anything not actually run as an assumption; take numbers from logs or tracking runs, never from memory; redact secrets; get the date from `date +%F`. **Write only what a future session would otherwise have to rediscover.**

## 1. `handoff.md`: overwrite

Read the existing file only to see which of its open items closed this session, then rewrite end to end.

1. **Done / resolved**: what changed, what ran, what came out. Every claim carries its evidence: a metric, an error that stopped firing, a diff path.
2. **Open / in progress**: running, stuck (symptom, what's ruled out, next thing to try), and untested hypotheses. Tag each `in progress` / `blocked` / `needs verification` / `parked (reason)`.
3. **Reference**: files touched, one line each; **copy-pasteable** commands with config paths, checkpoints, overrides and env vars, never "run the training script"; links to tracking runs, issues, arXiv, commits.

Arguments say what the next session is for: compress everything unrelated.

## 2. `docs/experiments/NNN-<slug>.md`: curate

One file per research question, not per run. Runs were logged as rows during the session (see the rule in `CLAUDE.md`); check that every run that produced an eval metric has its row, and add any that are missing.

```markdown
# NNN: <question>

**Question:** what this settles.
**Baseline:** the run and config everything is compared against.
**Conclusion:** `works` / `doesn't work` / `inconclusive`, and why. `open` until the runs settle it.

| Run | Commit | Change vs baseline | Result | Log |
|---|---|---|---|---|
```

- Write or update **Conclusion** once the runs settle the question.
- Delete rows that are only smoke tests or debug runs. A real run that failed stays: failures are the record.
- A run that opens a different question starts a new file.

## 3. `PITFALLS.md`: append

A flat list, appended at the bottom. Add an entry only for something that cost real effort to work out, or a workflow convention that isn't obvious from the code. Method conventions (axis order, normalization) belong in `Design.md`.

```markdown
- **<symptom>** (YYYY-MM-DD): cause, and the fix or how to avoid it.
```
