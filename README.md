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

Three documents, **three different lifetimes**. The split is the whole design — collapse them into one file and it rots.

| Document | Lifetime | Answers |
| --- | --- | --- |
| 📌 `handoff.md` | current state, **overwritten** each session | *Where am I right now?* |
| 📜 `CHANGELOG.md` | experiment history, **append-only** | *What did we already try, and what came of it?* |
| 🧭 `Design.md` | current design, **patched in place** | *How does this pipeline actually work?* |

A failed experiment never leaves `CHANGELOG.md`. A superseded design never lingers in `Design.md`. Yesterday's state never clutters `handoff.md`.

## 📦 Install

```bash
npx skills@latest add CUTEPKQ/radiance-skills
```

Pick the skills you want and which agents to install them on. Update later with `npx skills update`.

## ⚙️ Use

```bash
/setup-research     # once per project — records launch commands and layout into CLAUDE.md
/design             # write or update Design.md
/handoff            # end of session — rewrite handoff.md, append to CHANGELOG.md
/grill-me           # before you build — get interviewed until the plan has no soft spots
```

## 🧰 The skills

### 🔧 [setup-research](./skills/setup-research/SKILL.md)

Run once per project. Digs through `pyproject.toml`, `Makefile`, `scripts/`, `configs/` and the git log itself, asks only what it couldn't find — one question at a time — and writes the result into the project's `CLAUDE.md`, which every session loads automatically. **Never records a command it hasn't confirmed exists**; unverifiable ones are tagged `unverified` rather than presented as fact.

### 🧭 [design](./skills/design/SKILL.md)

Maintains `Design.md`: the pipeline stage by stage — purpose, in/out **with tensor shapes**, the mechanism in enough detail to reimplement, where it lives in code, hyperparameters tagged `paper default` / `empirical` / `arbitrary`, why it's built that way and what would overturn that, and what each stage assumes of its neighbours. Plus the global conventions — axis order, normalization, masking — that cross-stage bugs come from.

Patches in place, never regenerates. Where document and code disagree, the code wins.

### 📌 [handoff](./skills/handoff/SKILL.md)

Rewrites `handoff.md` end to end: what got done (with evidence — a metric, an error that stopped firing, a diff path), what's open (tagged `in progress` / `blocked` / `needs verification` / `parked`), and **copy-pasteable** commands, never "run the training script".

Then appends to `CHANGELOG.md` — **one entry per experiment, not per session**, and nothing at all if nothing was tried. Existing entries are never edited, so failures stay on the record permanently.

### 🔥 [grill-me](./skills/grill-me/SKILL.md)

A relentless interview, one question at a time, each with the agent's recommended answer, until every branch of the decision tree is resolved. Facts it can look up, it looks up; the decisions are yours. It won't act until you confirm you've reached a shared understanding.

Run it before an experiment, not after: it forces the questions that are expensive to answer late — what's the control, does the metric measure what you think, and **what result would kill this idea**.

## 🙏 Acknowledgements

This repo stands on [**mattpocock/skills**](https://github.com/mattpocock/skills) — Matt Pocock's *Skills For Real Engineers*.

- **`grill-me` is his work, copied verbatim.** The only change is a merge: upstream splits the front door (`grill-me`) from the interview loop (`grilling`) because a second front door, `grill-with-docs`, shares that loop. With one front door here, the two collapse into one file. The interview text is his, word for word.
- **`handoff` began as a fork of his `handoff`** and has since been rewritten around a different job — research sessions rather than software tickets.

`design` and `setup-research` are original, but the shape they take — small, hackable, composable, one file each — is copied from him on purpose. Go read [his repo](https://github.com/mattpocock/skills) in full; it is better than this one.

## 📄 License

MIT. Portions derive from mattpocock/skills, also MIT — see [LICENSE](./LICENSE).
