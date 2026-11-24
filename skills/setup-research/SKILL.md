---
name: setup-research
description: Record a research project's launch commands, layout and doc conventions into its CLAUDE.md. Run once per project.
argument-hint: "(none)"
disable-model-invocation: true
---

# Setup Research Project

Record this project's conventions into its root `CLAUDE.md`, so `handoff` and `design` stop guessing at them. `CLAUDE.md` is auto-loaded every session, so nothing has to remember to read a config file.

1. **Dig before asking.** Read `README`, `pyproject.toml` / `requirements.txt` / `environment.yml`, `Makefile` / `justfile` / `scripts/`, `configs/`, `.gitignore`, `git log --oneline -30`. Deps reveal the training stack; `scripts/` usually holds the real launch commands.
2. **Ask only what's left** — one question at a time, each with your recommended answer.
3. **Never invent a command.** Confirm the script or entry point exists; if you can't, record it tagged `unverified`.
4. **Write the block** into the root `CLAUDE.md`, wrapped in `<!-- research-conventions:start -->` / `<!-- research-conventions:end -->` so re-running updates only this block. Drop any subsection with no real answer — an honest gap beats a plausible fabrication.

```markdown
## Research project conventions

### Docs
- `handoff.md` — current state, overwritten (path)
- `Design.md` — current pipeline design (path)
- `docs/experiments/` — one file per research question, runs as table rows (path). Read before proposing or launching an experiment: it may already have been tried.
- `PITFALLS.md` — hard-won pitfalls, flat list (path). Read before debugging, or changing the environment, data pipeline or launch setup.
- `docs/adr/` — decisions that are hard to reverse (path). Read before changing a design decision: it may already have been rejected.

When a run produces an eval metric, immediately append a row to its file in `docs/experiments/`: Run | Commit (`git rev-parse --short HEAD`, plus `dirty` if the tree has uncommitted changes) | Change vs baseline | Result (from the log) | Log path. Skip smoke tests and debug runs. If no file fits, create one with only the question, baseline and table; leave the conclusion to `/handoff`. `Design.md` and ADRs are written by `/grill-with-docs` or `/design`; every other doc above only by `/handoff`, or when the user asks.

### Environment
- Activate: <conda / venv / uv>
- GPUs: <count, launcher and its flags>

### Commands
- Train / Eval / Quick debug run — full command lines

### Layout
- Configs / checkpoints / logs / datasets
```

5. **Version control.** Everything in Docs except `handoff.md` is the project's memory and belongs in git; ask whether to gitignore `handoff.md`.
6. Show the block, flagging anything `unverified`.
