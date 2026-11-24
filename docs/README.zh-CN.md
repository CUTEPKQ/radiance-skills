<h1 align="center">✨ Radiance Skills</h1>

<p align="center">
  面向 <b>research project</b> 的 agent skills —— 让方法、实验和走过的死路在多轮会话之间保持可读。
</p>

<p align="center">
  <a href="https://skills.sh/CUTEPKQ/radiance-skills"><img alt="skills.sh" src="https://skills.sh/b/CUTEPKQ/radiance-skills"></a>
  <img alt="MIT" src="https://img.shields.io/badge/license-MIT-blue.svg">
</p>

<p align="center">
  <a href="../README.md">English</a> · <b>简体中文</b>
</p>

---

## 🔬 问题

研究代码是按实验推进的，不是按 ticket。你试了个东西，半成功，顺手改了三个地方——两周后没人说得清 pipeline 为什么长这样，也没人记得哪个变体已经失败过。包括你自己。

agent 让这件事更糟：每次会话都从零开始，重新猜你的启动命令，然后兴高采烈地建议你上周二刚排除掉的方案。

## 🗂 思路

每份文档**一种生命周期、一件事**。这个切分就是全部设计——合成一个文件它就会烂掉。

| 文档 | 生命周期 | 回答什么 |
| --- | --- | --- |
| 📌 `handoff.md` | 当下状态，每次会话**整份覆盖** | *我现在到哪了？* |
| 🧭 `Design.md` | 当前设计，**原地打补丁** | *这条 pipeline 到底怎么跑的？* |
| 🧪 `docs/experiments/` | 一个研究问题一份，run 作为表格行 | *试过什么，结论如何？* |
| 🕳 `PITFALLS.md` | 费力才想通的坑，**追加** | *什么会再咬我一口？* |
| ⚖️ `docs/adr/` | 决策，**理由永不改写**，被取代时只标状态 | *为什么这么设计，取代了什么？* |

失败的 run 永远留在实验文件里；被推翻的设计不会滞留在 `Design.md`，但理由留在 ADR；昨天的状态不会堆在 `handoff.md` 里。

run 一产出指标就**立刻记一行**，带上当时的 commit，所以就算没来得及 `/handoff` session 就断了，结果也不会丢。结论和踩坑留给能看到整个 session 的 `/handoff`；设计决策由 `/grill-with-docs` 在理由还在对话里的时候记下来。

## 📦 安装

```bash
npx skills@latest add CUTEPKQ/radiance-skills
```

选你要的 skill 和要装到哪些 agent 上。之后用 `npx skills update` 更新。

## ⚙️ 用法

```bash
/setup-research     # 每个项目跑一次 —— 把启动命令和目录约定写进 CLAUDE.md
/grill-me           # 动手之前 —— 被追问到计划没有软肋为止
/grill-with-docs    # 同上，同时随决策就地修改 Design.md、写 ADR
/design             # 编写或更新 Design.md
/handoff            # 收工时 —— 重写 handoff.md，整理本轮定下来的东西
/keep-going         # 下次开工 —— 从 handoff.md 接续
```

## 🧰 skill 清单

### 🔧 [setup-research](../skills/setup-research/SKILL.md)

每个项目跑一次。自己去翻 `pyproject.toml`、`Makefile`、`scripts/`、`configs/` 和 git log，**只问它扒不出来的**，而且一次只问一个。结论写进项目的 `CLAUDE.md`——那个文件每轮会话自动加载，所以其他 skill 不需要记得去读配置。

一条硬约束：**没确认存在的命令不许写成事实**，只能标 `unverified`。凭空编一条跑不通的启动命令，比不写更糟。

### 🧭 [design](../skills/design/SKILL.md)

维护 `Design.md`，分两部分。**Motivation**：要解决的问题、现有方法差在哪、核心思路、什么算成功。**Pipeline**：先讲清端到端的输入 → 输出并画流程图，再逐阶段写输入输出（**带 tensor shape**）、每一步的流程、代码在哪、为什么这么设计。

### 📌 [handoff](../skills/handoff/SKILL.md)

整份重写 `handoff.md`：本轮做完了什么（**必须带证据**——一个指标、一个不再报的错、一条 diff 路径）、什么还开着（标 `in progress` / `blocked` / `needs verification` / `parked`）、以及**可直接复制执行**的命令，禁止写「跑一下训练脚本」这种废话。

然后整理本轮定下来的东西：结论写进实验文件（删掉 debug 行，失败的 run 保留）、费力才想通的坑写进 `PITFALLS.md`。数字从日志取，不凭记忆；没定下来的，一条不写。

### ▶️ [keep-going](../skills/keep-going/SKILL.md)

`handoff` 的另一端。读 `handoff.md`，然后**先拿现实核对一遍再决定信不信它**——文档是某个时间点写的，世界往前走了：它写着「训练中，明天看」的那个 run，可能二十分钟后就挂了。先报这个 delta，然后**只接一件事**。

刻意**不读**历史（实验文件、ADR、踩坑）：为了接续而重读全部过往实验是纯浪费 context。`CLAUDE.md` 里给每份文档留了一条指针，写明什么时候该读（开新实验前、改设计决策前、debug 前），所以不管是不是从 keep-going 开始，每个 session 都会在对的时候去查。

### 🔥 [grill-me](../skills/grill-me/SKILL.md)

穷尽式追问，按轮次推进：每一轮把前置条件已经定下来的问题一次问完，逐个编号并附上 agent 的推荐答案，直到 decision tree 的每个分支都有着落。能查的事实交给 subagent 在后台查，**决策留给你**。你没确认达成 shared understanding 之前，它不许动手。

在实验之前跑，不是之后：它逼你回答那些拖到后面才发现代价极高的问题——对照组是什么、这个指标测的是不是你以为的东西、以及**什么结果算这个想法死了**。

### 🔥📝 [grill-with-docs](../skills/grill-with-docs/SKILL.md)

`grill-me` 加上文档。每个问题都先带上已有的证据（实验结果、已接受的 ADR）；和 `Design.md` 或代码矛盾的地方当场指出；用边界场景逼出设计的边界。决策一落地就就地修改 `Design.md`（未实现的部分标 `planned`），并且**只有**同时满足"难以回退、没背景会困惑、确实有取舍"才写 ADR。ADR 只在这里写：理由趁还在对话里时记下来，而不是事后重建。

### ✍️ [writing-for-agents](../skills/writing-for-agents/SKILL.md)

写任何给 agent 读的文档时的参考：skill、`CLAUDE.md`、被指针引用的文档。讲 context pointer、两种负载（context load 和 cognitive load）、信息层级、完成判据、leading word，以及逐句删到不剩 no-op。你新建或修改 skill、改 `CLAUDE.md` / `AGENTS.md` 时，agent 会自己调用它。

## 🙏 致谢

这个 repo 建立在 [**mattpocock/skills**](https://github.com/mattpocock/skills)（Matt Pocock 的 *Skills For Real Engineers*）之上。

- **`grill-me` 是他的作品，逐字拷贝。** 唯一的改动是合并：上游把入口（`grill-me`）和追问循环（`grilling`）拆成两个，因为还有第二个入口 `grill-with-docs` 共用那个循环；这里追问循环直接放在 `grill-me` 里，`grill-with-docs` 调用它。追问的正文一字未改，全是他写的。
- **`grill-with-docs` 改编自他的 `grill-with-docs` 和 `domain-modeling`**：去掉了 glossary（约定由 `Design.md` 承载），挑战的对象换成 `Design.md`、实验结果和 ADR。
- **`writing-for-agents` 是他的作品，逐字拷贝。**
- **`handoff` 最初是他 `handoff` 的 fork**，之后为了另一件事重写了——研究会话，而不是软件工单。

`design` 和 `setup-research` 是原创，但它们的形态——小、易改、可组合、一个文件一件事——是刻意照抄他的。去把[他的 repo](https://github.com/mattpocock/skills) 完整读一遍，那个比这个好。

## 📄 License

MIT。部分内容源自 mattpocock/skills，同为 MIT —— 见 [LICENSE](../LICENSE)。
