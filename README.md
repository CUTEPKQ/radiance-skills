# my_skills

My own skills — customised forks of upstream skills, plus anything I write from scratch.

Kept outside `~/Workspace/skills` on purpose: that clone tracks `mattpocock/skills` upstream, so editing skills in place would conflict on every `git pull`. Forks live here instead and are free to diverge.

Run `./link.sh` to symlink these into `~/.claude/skills`. Re-run it after adding or renaming a skill.

| skill | origin | what changed |
| --- | --- | --- |
| [handoff](./handoff/SKILL.md) | fork of `skills/productivity/handoff` | Writes `handoff.md` to the **project root** instead of the OS temp dir; **overwrites** each session rather than accumulating history; fixed three-section structure (done / open / reference); requires evidence on every claim, verified-vs-assumed labelling, honest failure records, and copy-pasteable experiment commands. |
| [grill-me](./grill-me/SKILL.md) | merge of `skills/productivity/grill-me` + `skills/productivity/grilling` | Upstream splits the front door from the loop because `grill-with-docs` shares the loop; with only one front door here, the interview text lives directly in `grill-me`. Body is upstream's verbatim. Now model-invocable, so `/grill-me` *and* plain "grill me on this" both work. |
