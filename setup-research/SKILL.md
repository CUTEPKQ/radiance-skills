---
name: setup-research
description: Configure a research project for the handoff / design skills — record its launch commands, tracking setup, and doc conventions into the project's CLAUDE.md. Run once per project.
argument-hint: "(no arguments needed)"
disable-model-invocation: true
---

# Setup Research Project

Record this project's conventions into its root `CLAUDE.md`, so `handoff` and `design` stop guessing at them. Run once per project; re-run when the conventions change.

Everything lands in `CLAUDE.md` on purpose — it is loaded automatically every session, so nothing has to remember to read a config file.

## Process

### 1. Investigate before asking

Dig the answers out of the project yourself. Do not ask the user anything you can find. Read whatever exists:

- `README.md`, `CONTRIBUTING.md`, and any `docs/`
- `pyproject.toml` / `requirements.txt` / `environment.yml` / `uv.lock` — deps reveal the training stack (`accelerate`, `deepspeed`, `lightning`, `hydra`, `wandb`)
- `Makefile`, `justfile`, `scripts/`, `*.sh` — the real launch commands usually live here
- `configs/` or `conf/` — config system and layout
- `.gitignore` — what the project already treats as disposable
- `git log --oneline -30` — what has actually been worked on

### 2. Ask only for what's left

**One question at a time, each with your recommended answer.** Never batch them. Only ask what the investigation couldn't settle.

### 3. Never invent a command

A command you have not confirmed is wrong more often than it is right. For each command you record, check the script or entry point actually exists. If you cannot confirm it, write it down tagged `unverified` rather than presenting it as fact.

### 4. Write the block

Insert into the project root `CLAUDE.md` (create the file if absent), wrapped in these markers so re-running updates only this block and leaves the rest of the file untouched:

```markdown
<!-- research-conventions:start -->
## Research project conventions

### Docs
- `handoff.md` — current session state, overwritten each time (path: ...)
- `CHANGELOG.md` — experiment history, append-only, newest first (path: ...)
- `Design.md` — current pipeline design, updated in place (path: ...)

### Environment
- Activate: <conda activate x / source .venv/bin/activate / uv run>
- GPUs: <single / N per node, launcher and its flags>

### Commands
- Train: <full command line>
- Eval: <full command line>
- Quick debug run: <smallest command that exercises the pipeline end to end>

### Layout
- Configs: <dir + config system>
- Checkpoints: <dir + naming>
- Logs: <dir>
- Datasets: <paths or how they're resolved>

### Experiment tracking
- <wandb entity/project, or tensorboard logdir, or none>
<!-- research-conventions:end -->
```

Drop any subsection the project genuinely has no answer for. An honest gap beats a plausible fabrication.

### 5. Settle version control for the docs

`CHANGELOG.md` and `Design.md` belong in version control — they are the project's memory. `handoff.md` is a transient scratch state; ask whether to add it to `.gitignore`, and do it if they say yes.

### 6. Report

Show the user the block you wrote, and call out separately anything tagged `unverified` so they can correct it.

## Language

Write in the language of the conversation (Chinese by default). Keep technical terms in English — do not translate them.
