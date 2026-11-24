<h1 align="center">✨ Radiance Skills</h1>

<p align="center">
  Agent skills for <b>research projects</b> — keeping a method, its experiments, and its dead ends legible across sessions.
</p>

<p align="center">
  <a href="https://skills.sh/CUTEPKQ/radiance-skills"><img alt="skills.sh" src="https://skills.sh/b/CUTEPKQ/radiance-skills"></a>
  <img alt="MIT" src="https://img.shields.io/badge/license-MIT-blue.svg">
</p>

<p align="center">
  <b>English</b> · <a href="./docs/README.zh-CN.md">简体中文</a>
</p>

---

## 🔬 The problem

Research code moves by experiment, not by ticket. You try something, it half-works, you change three things, and two weeks later nobody — you included — can say why the pipeline looks like this or which variant already failed.

Agents make it worse: every session starts cold, re-derives your launch command, and cheerfully suggests the thing you ruled out last Tuesday.

## 🗂 The idea

Each document has **one lifetime and one job**. The split is the whole design — collapse them into one file and it rots.

| Document | Lifetime | Answers |
| --- | --- | --- |
| 📌 `handoff.md` | current state, **overwritten** each session | *Where am I right now?* |
| 🧭 `Design.md` | current design, **patched in place** | *How does this pipeline actually work?* |
| 🧪 `docs/experiments/` | one file per research question, runs as rows | *What did we try, and what came of it?* |
| 🕳 `PITFALLS.md` | hard-won pitfalls, **appended** | *What will bite me again?* |
| ⚖️ `docs/adr/` | decisions, **never rewritten**, superseded in place | *Why is it built this way, and what did it replace?* |

A failed run never leaves its experiment file. A superseded design never lingers in `Design.md`, but its reasoning survives in an ADR. Yesterday's state never clutters `handoff.md`.

Runs are logged **the moment they produce a metric**, with the commit they ran on, so nothing is lost if a session dies before `/handoff`. Conclusions and pitfalls wait for `/handoff`, which sees the whole session; design decisions are recorded by `/grill-with-docs`, while the reasoning is still in the conversation.

## 📦 Install

```bash
npx skills@latest add CUTEPKQ/radiance-skills
```

Pick the skills you want and which agents to install them on. Update later with `npx skills update`.

## ⚙️ Use

```bash
/setup-research     # once per project — records launch commands and layout into CLAUDE.md
/grill-me           # before you build — get interviewed until the plan has no soft spots
/grill-with-docs    # same, but patches Design.md and writes ADRs as decisions land
/design             # write or update Design.md
/handoff            # end of session — rewrite handoff.md, file what was settled
/keep-going         # start of the next one — resume from handoff.md
```

## 🧰 The skills

### 🔧 [setup-research](./skills/setup-research/SKILL.md)

Run once per project. Digs through `pyproject.toml`, `Makefile`, `scripts/`, `configs/` and the git log itself, asks only what it couldn't find — one question at a time — and writes the result into the project's `CLAUDE.md`, which every session loads automatically. **Never records a command it hasn't confirmed exists**; unverifiable ones are tagged `unverified` rather than presented as fact.

### 🧭 [design](./skills/design/SKILL.md)

Maintains `Design.md` in two parts. **Motivation**: the problem, where existing methods fall short, the core idea, and what counts as success. **Pipeline**: the end-to-end input → output and a flow diagram, then each stage with its in/out **with tensor shapes**, its flow step by step, where it lives in code, and why it's built that way.

### 📌 [handoff](./skills/handoff/SKILL.md)

Rewrites `handoff.md` end to end: what got done (with evidence — a metric, an error that stopped firing, a diff path), what's open (tagged `in progress` / `blocked` / `needs verification` / `parked`), and **copy-pasteable** commands, never "run the training script".

Then files what the session settled: conclusions into the experiment files (debug rows dropped, failed runs kept), and hard-won lessons into `PITFALLS.md`. Numbers come from logs, never memory; nothing settled, nothing written.

### ▶️ [keep-going](./skills/keep-going/SKILL.md)

The other end of `handoff`. Reads `handoff.md`, then **verifies it against reality before trusting a word of it** — the doc was written at a point in time and the world moved on, so the run it left "training, check tomorrow" may have died twenty minutes later. Reports that delta first, then takes exactly one open item.

Deliberately does *not* read the history (experiments, ADRs, pitfalls): re-reading every past experiment to resume is wasted context. `CLAUDE.md` carries a pointer to each, saying when to read it (before launching an experiment, before changing a decision, before debugging), so every session checks them at the right moment, resumed or not.

### 🔥 [grill-me](./skills/grill-me/SKILL.md)

A relentless interview, worked in rounds: each round asks every question whose prerequisites are already settled, numbered, each with the agent's recommended answer, until every branch of the decision tree is resolved. Facts it can look up, a sub-agent looks up in the background; the decisions are yours. It won't act until you confirm you've reached a shared understanding.

Run it before an experiment, not after: it forces the questions that are expensive to answer late — what's the control, does the metric measure what you think, and **what result would kill this idea**.

### 🔥📝 [grill-with-docs](./skills/grill-with-docs/SKILL.md)

`grill-me`, plus the docs. Each question arrives with the evidence already on file (experiment results, accepted ADRs), contradictions with `Design.md` or the code get called out on the spot, and edge-case scenarios force the design's boundaries into the open. As decisions land, it patches `Design.md` (unbuilt parts tagged `planned`) and writes an ADR **only** when a decision is hard to reverse, surprising without context, *and* a real trade-off. The only place ADRs get written: the reasoning is recorded while it's still in the conversation, not reconstructed later.

### ✍️ [writing-for-agents](./skills/writing-for-agents/SKILL.md)

The reference for writing anything an agent reads: a skill, a `CLAUDE.md`, a doc behind a pointer. Context pointers, the two loads, the information hierarchy, completion criteria, leading words, and pruning down to no-ops. The agent reaches for it on its own when you create or edit a skill or touch `CLAUDE.md` / `AGENTS.md`.

## 🙏 Acknowledgements

This repo stands on [**mattpocock/skills**](https://github.com/mattpocock/skills) — Matt Pocock's *Skills For Real Engineers*.

- **`grill-me` is his work, copied verbatim.** The only change is a merge: upstream splits the front door (`grill-me`) from the interview loop (`grilling`) because a second front door, `grill-with-docs`, shares that loop. Here the loop lives in `grill-me` itself, and `grill-with-docs` calls it. The interview text is his, word for word.
- **`grill-with-docs` is adapted from his `grill-with-docs` and `domain-modeling`**: the glossary is dropped (`Design.md` carries the conventions), and the challenges point at `Design.md`, experiment results and ADRs instead.
- **`writing-for-agents` is his work, copied verbatim.**
- **`handoff` began as a fork of his `handoff`** and has since been rewritten around a different job — research sessions rather than software tickets.

`design` and `setup-research` are original, but the shape they take — small, hackable, composable, one file each — is copied from him on purpose. Go read [his repo](https://github.com/mattpocock/skills) in full; it is better than this one.

## 📄 License

MIT. Portions derive from mattpocock/skills, also MIT — see [LICENSE](./LICENSE).
