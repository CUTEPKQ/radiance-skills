---
name: keep-going
description: Resume from handoff.md — verify what actually happened since, then carry on.
argument-hint: "(optional) which open item to pick up"
disable-model-invocation: true
---

# Keep Going

Pick up where the last session stopped. `handoff.md` at the project root (unless `CLAUDE.md` says otherwise) is the state; never make the user re-explain what it already says.

1. **Read `handoff.md`.** If it isn't there, say so and ask what to work on rather than reconstructing intent from the git log.
2. **Verify before trusting it.** The document was written at a point in time and the world moved on. Check every *Open / in progress* item against reality — is the job alive, did the checkpoint land, did the run finish or die, does the working tree match what the doc claims? Check by observing, not by reasoning: process and GPU status, log tails, checkpoint files, `git status`. Verification is read-only: never relaunch a run from the Reference section.
3. **Report the delta first** — what changed since the handoff was written, especially anything that failed silently. Then propose the next move.
4. **Take one item.** With several open and no argument given, recommend one and ask. Don't start three things at once.

`handoff.md` carries the state: read the experiment docs, ADRs and `PITFALLS.md` only when their pointers in `CLAUDE.md` say to. Read `Design.md` only when the work touches the method itself.

`handoff` closes the loop at the other end.
