# my_skills

My own skills — customised forks of upstream skills, plus anything I write from scratch.

Kept outside `~/Workspace/skills` on purpose: that clone tracks `mattpocock/skills` upstream, so editing skills in place would conflict on every `git pull`. Forks live here instead and are free to diverge.

Run `./link.sh` to symlink these into `~/.claude/skills`. Re-run it after adding or renaming a skill.

## The research-project set

Three documents at the project root, with three different lifetimes — the split is the whole design:

| document | lifetime | written by |
| --- | --- | --- |
| `handoff.md` | current state, **overwritten** each session | `/handoff` |
| `CHANGELOG.md` | experiment history, **append-only**, newest first | `/handoff` |
| `Design.md` | current pipeline design, **updated in place** | `/design` |

`/setup-research` runs once per project and records that project's launch commands, layout and doc paths into its `CLAUDE.md`, so the other two stop guessing.

## Skills

| skill | origin | notes |
| --- | --- | --- |
| [handoff](./handoff/SKILL.md) | fork of `mattpocock/skills` `productivity/handoff` | Writes to the **project root** instead of the OS temp dir. Overwrites `handoff.md` each session rather than accumulating, and appends the session's experiments to `CHANGELOG.md` — one entry per experiment, never per session. Requires evidence on every claim, verified-vs-assumed labelling, honest failure records, and copy-pasteable experiment commands. |
| [design](./design/SKILL.md) | written from scratch | Maintains `Design.md`: how the pipeline is built, stage by stage — purpose, in/out with shapes, the mechanism in reimplementable detail, where it lives in code, hyperparameter provenance, why it's built that way, and what it assumes of its neighbours. Plus global conventions (axis order, normalization, masking) and known limitations. Patches in place; never regenerates. |
| [setup-research](./setup-research/SKILL.md) | written from scratch | Investigates the project first, asks only what it can't find, writes a marker-delimited block into the project's `CLAUDE.md`. Never records a command it hasn't confirmed exists. |
| [grill-me](./grill-me/SKILL.md) | merge of `mattpocock/skills` `grill-me` + `grilling` | Upstream splits the front door from the loop because `grill-with-docs` shares that loop; with only one front door here, the interview text lives directly in `grill-me`. Body is upstream's verbatim. Model-invocable, so `/grill-me` *and* plain "grill me on this" both work. |
