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

三份文档，**三种不同的生命周期**。这个切分就是全部设计——合成一个文件它就会烂掉。

| 文档 | 生命周期 | 回答什么 |
| --- | --- | --- |
| 📌 `handoff.md` | 当下状态，每次会话**整份覆盖** | *我现在到哪了？* |
| 📜 `CHANGELOG.md` | 实验历史，**只追加** | *我们已经试过什么，结论如何？* |
| 🧭 `Design.md` | 当前设计，**原地打补丁** | *这条 pipeline 到底怎么跑的？* |

失败的实验永远留在 `CHANGELOG.md`；被推翻的设计不会滞留在 `Design.md`；昨天的状态不会堆在 `handoff.md` 里。

## 📦 安装

```bash
npx skills@latest add CUTEPKQ/radiance-skills
```

选你要的 skill 和要装到哪些 agent 上。之后用 `npx skills update` 更新。

## ⚙️ 用法

```bash
/setup-research     # 每个项目跑一次 —— 把启动命令和目录约定写进 CLAUDE.md
/design             # 编写或更新 Design.md
/handoff            # 收工时 —— 重写 handoff.md，追加 CHANGELOG.md
/grill-me           # 动手之前 —— 被追问到计划没有软肋为止
```

## 🧰 skill 清单

### 🔧 [setup-research](../skills/setup-research/SKILL.md)

每个项目跑一次。自己去翻 `pyproject.toml`、`Makefile`、`scripts/`、`configs/` 和 git log，**只问它扒不出来的**，而且一次只问一个。结论写进项目的 `CLAUDE.md`——那个文件每轮会话自动加载，所以其他 skill 不需要记得去读配置。

一条硬约束：**没确认存在的命令不许写成事实**，只能标 `unverified`。凭空编一条跑不通的启动命令，比不写更糟。

### 🧭 [design](../skills/design/SKILL.md)

维护 `Design.md`，逐阶段展开 pipeline：这一步负责什么、输入输出（**带 tensor shape**）、机制细到能照着重新实现、代码在哪、超参标来源（`paper default` / `empirical` / `arbitrary`）、为什么这么设计以及什么证据能推翻它、对上下游的假设。外加一节 global conventions——axis order、normalization、masking，跨阶段的 bug 都从这里来。

原地打补丁，绝不重新生成。文档和代码打架时，**以代码为准**。

### 📌 [handoff](../skills/handoff/SKILL.md)

整份重写 `handoff.md`：本轮做完了什么（**必须带证据**——一个指标、一个不再报的错、一条 diff 路径）、什么还开着（标 `in progress` / `blocked` / `needs verification` / `parked`）、以及**可直接复制执行**的命令，禁止写「跑一下训练脚本」这种废话。

然后追加 `CHANGELOG.md`——**一次实验一条，不是一个 session 一条**，没做实验就一条不写。既有条目永不修改，失败永久留档。

### 🔥 [grill-me](../skills/grill-me/SKILL.md)

穷尽式追问：一次一个问题，每个都附上 agent 自己的推荐答案，直到 decision tree 的每个分支都有着落。能查的事实它自己查，**决策留给你**。你没确认达成 shared understanding 之前，它不许动手。

在实验之前跑，不是之后：它逼你回答那些拖到后面才发现代价极高的问题——对照组是什么、这个指标测的是不是你以为的东西、以及**什么结果算这个想法死了**。

## 🙏 致谢

这个 repo 建立在 [**mattpocock/skills**](https://github.com/mattpocock/skills)（Matt Pocock 的 *Skills For Real Engineers*）之上。

- **`grill-me` 是他的作品，逐字拷贝。** 唯一的改动是合并：上游把入口（`grill-me`）和追问循环（`grilling`）拆成两个，因为还有第二个入口 `grill-with-docs` 共用那个循环；这里只有一个入口，所以两者合成一个文件。追问的正文一字未改，全是他写的。
- **`handoff` 最初是他 `handoff` 的 fork**，之后为了另一件事重写了——研究会话，而不是软件工单。

`design` 和 `setup-research` 是原创，但它们的形态——小、易改、可组合、一个文件一件事——是刻意照抄他的。去把[他的 repo](https://github.com/mattpocock/skills) 完整读一遍，那个比这个好。

## 📄 License

MIT。部分内容源自 mattpocock/skills，同为 MIT —— 见 [LICENSE](../LICENSE)。
