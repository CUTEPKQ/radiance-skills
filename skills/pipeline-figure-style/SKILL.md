---
name: pipeline-figure-style
description: Our own house style for ML/CV paper pipeline / method / framework / architecture figures. Use whenever the user wants to draw, design, redesign, critique, or describe a pipeline figure, method overview, framework diagram, model architecture figure, or "Figure 2" / teaser-style overview for a paper, poster, slide, or blog — whether output is HTML/SVG, a spec for draw.io / Figma / PPT / Illustrator, or feedback on an existing figure. Also use when the user says "按我喜欢的风格画 pipeline", "画方法图", "框架图", "method figure".
---

# Pipeline Figure Style

This is our own figure style. Follow it directly; do not go looking for or imitate other papers' figures.

One-line summary: **pastel, low-saturation panels on white, one hue per module, dense but orderly, real data thumbnails at the edges, 🔥/❄️ training-state icons, rounded boxes, LaTeX math labels.**

## 1. Layout

- **Canvas**: landscape, aspect **~2:1 to 2.3:1** (e.g. 2000×900). Single-column-width figures go down to ~1.4:1.
- **Macro structure**: 2–4 large **module panels** (rounded rectangles, pale fill) tiling the canvas. Common arrangements:
  - Left→right flow: `inputs | core model | outputs/losses` (most common).
  - Top row = main pipeline, bottom row = zoom-in details of 1–2 sub-modules.
  - Big left panel = architecture, right panel = detail/zoom.
  - Staged: `Step I → Step II → Step III` columns.
- **Panel labels**: either `(a) Name` / `(b) Name` placed at the panel's top-left or bottom-center, or Roman `I. Name` / `II. Name` in a title bar. Label text is **bold**, sometimes italic, colored to match the panel hue or near-black `#232323`.
- **Zoom-in convention**: a dashed callout / dashed lines from a small block in the main path to an enlarged detail panel.
- **Repetition**: stacked layered cards (3 offset copies) or a `× N` / `× L times` badge for repeated blocks.
- **Density**: high but tidy — every panel filled, consistent gutters (~1–1.5% of width), strict alignment to a grid. No large empty areas.
- **Legend**: a dashed-border legend strip at the bottom or a boxed legend at a corner explaining arrow types, symbols (⊕ ⊙ ⊗ Ⓒ), and 🔥/❄️.

## 2. Color

White background, pastel fills, and a small amount of saturated accent. **Saturation carries meaning, not decoration.**

### 2.1 Area budget (share of the whole canvas)

| Layer | Share | Notes |
|---|---|---|
| White `#FFFFFF` | ~35% | Canvas + gutters between panels |
| Neutral gray panels `#F5F5F5` / `#EBEBEB` | ~12% | Very common as the container for a secondary module or legend strip |
| Pale colored panel fills | ~27% | The main source of color — whole panels in soft tints |
| Mid-tone block fills | ~4% | Blocks/tokens inside panels; roughly **pale : mid ≈ 7 : 1** |
| Saturated accents | <1% | Key arrows, losses, method name, "ours" box |
| Real imagery (photos/renders) | rest | Inputs/outputs at the edges |

So: mostly white + pale; mid tones sparingly; accents almost as punctuation.

### 2.2 Hue families (how often each appears, ≥2% area)

| Family | Frequency | Pale panel | Mid block | Accent / stroke |
|---|---|---|---|---|
| **Blue** | ★★★★★ ~75% of figures | `#D7E1F5` (lighter `#EEF3FC`) | `#A5B9E1` · sky `#B9E1F5` | `#375FC3` · light `#5F9BE1` |
| **Orange / peach** | ★★★★☆ ~70% | `#FFF5EB` · `#F5E1CD` | `#FFCD91` · `#F5CDB9` | `#EB7D41` |
| **Yellow / cream** | ★★★★☆ ~60% | `#FFF5E1` · `#FFF5CD` | `#FFE191` | `#E1B955` |
| Green / sage | ★★☆☆☆ ~35% | `#EBF5E1` · `#D7EBCD` | `#B9D7A5` · `#CDEBC3` | `#417323` (dark) · `#91D773` |
| **Red / pink** ⭐ preferred | ★★☆☆☆ ~30% | `#FFEBEB` · `#F5EBEB` | `#F5B9A5` · `#E1B9B9` | `#E16969` · deep `#AF0505` |
| **Lavender** ⭐ preferred | ★★★☆☆ ~40% | `#F0EBFF` · `#F5EBFF` (lighter `#FAF5FF`) · dusty `#EBE1F5` | `#C8B4F5` · `#D2C3FA` · dusty `#D2BEE1` / `#D7CDE1` | `#8C69A5` · deep `#55148C` |
| Teal | ★☆☆☆☆ ~15% | `#E1EBEB` · `#CDEBEB` | `#B9EBF5` | `#5FD7C3` · dark `#23697D` |
| Magenta | rare ~10% | `#F5EBF5` | `#F59BC3` | `#F54191` |
| Text / lines | — | — | — | Text: `#111111`–`#232323` only (no gray text). Lines: `#555555` or black |

The warm family (orange + yellow/cream) together takes up the largest area. Blue is the single most common hue and most often the **dominant** one.

**Red is also a preferred hue** (`#FFEBEB` pale · `#F5B9A5` mid · `#E16969` accent · `#AF0505` deep). Use it at least as an accent in most figures: the loss box (`#FFEBEB` fill + `#E16969` dashed border + `#AF0505` math), the red dashed box around the key component, or the key novel path. It can also fill a whole pale `#FFEBEB` panel for the novel module when lavender isn't already playing that role.

**Lavender is a preferred hue — reach for it before green / teal.** It reads as "the special one" without being loud. Typical uses seen in the reference set:
- The **trainable / novel module** in an otherwise blue-or-gray figure: e.g. a `#E6DCFA` block with `#A08CD2` stroke and 🔥 for a control branch next to a frozen gray text encoder.
- A whole **secondary panel** in pale lavender `#F0E6FA` with deep-plum (`#55148C`–`#5A0A64`) blocks inside — a strong pairing with a pale-blue main panel.
- **Decoder / core block + matching block arrows**: mid lavender `#C8B4F5` block, the big flow arrows in the same `#C8B4F5`, and deep `#55148C` output tokens.
- **Blue → lavender gradient** along an encoder stack (`#A5B9E1` → `#C8B4F5`), or lavender cells in attention-map heatmaps.
- Pale lavender rounded box for a query/prompt panel or one of several task heads.

### 2.3 Combination recipes (ranked by how often they co-occur)

Most figures use **3 hue families** (the most common count), then 4. 1–2 hues happen only in minimal figures; 5+ is rare.

- **Backbone pair: Blue + Orange** — present in ~57% of figures. Cool main module vs. warm secondary module. Default starting point.
- Next pairs: Blue + Yellow, Orange + Yellow (~43% each); then Blue + Green, Green + Yellow (~29%).

Triads, in order of preference:
1. **Blue + Orange + Yellow** (top, ~1/3 of figures) — blue for the core model, peach and cream for input / auxiliary panels.
2. **Blue + Orange + Red/pink** — red/pink panel marks the novel module or loss.
3. **Blue + Green + Orange** / **Blue + Green + Yellow** — green for a second branch or the output/task head.
4. **Green + Orange + Yellow** — all warm-natural, no blue; good when the figure is image-heavy.
5. **Blue + Lavender + Orange/Yellow** — preferred alternative to #1/#2: blue core, lavender for the novel/trainable module, warm tints for inputs/aux. Use this whenever the user hasn't asked for something else and there's a clear "ours" module.
6. **Lavender + Orange + Yellow** (lavender as dominant) — soft and warm; good for generation/editing figures.

### 2.4 Rules

- **One hue per module/panel.** Panel = pale tint; blocks inside = mid tint of the same hue, or of the partner hue for contrast (e.g. peach blocks inside a pale-blue panel).
- Pick one dominant hue (usually blue, else warm yellow/orange) for the largest panel; the other 1–3 hues take smaller panels.
- Use neutral gray `#F5F5F5` for "supporting" containers (legend, frozen backbone, inference-only) instead of adding another hue.
- Accent color follows the panel it belongs to (dark blue `#375FC3` in blue modules, `#EB7D41` in orange ones). Red `#E16969`/`#AF0505` is reserved for the key novel path, losses, or a red dashed box.
- Token/feature strips: rows of small squares in 2–3 mid tints drawn from the figure's own triad — a signature motif.
- Encoders/decoders: trapezoids in mid blue `#A5B9E1` or lavender `#C8B4F5`.
- Lavender pairs best with blue (cool harmony) and with cream/peach (complementary warmth). Avoid putting a lavender panel right next to a magenta or pale-pink panel, because they blur together. Red as a small accent (loss box, dashed box) next to lavender is fine and a good pairing.

## 3. Shapes & components

- **Blocks**: rounded rectangles, radius ~6–12 px at 2000 px width; 1–1.5 px stroke in darker same hue (or no stroke). Subtle drop shadow occasionally, never heavy.
- **Encoder/decoder**: trapezoid (wide→narrow for encoders, narrow→wide for decoders), often rotated text inside.
- **Tokens / features**: small squares or rounded squares in a row/column (`■■■■`), with `...` for continuation. Stacked translucent sheets for feature maps.
- **Transformer / stack**: 3 offset layered cards, or a tall block with `× N`.
- **Attention maps / matrices**: small heatmap grids (pastel blue-purple or orange-red), sometimes a masked matrix with light blue shaded cells.
- **Operators**: circled ⊕ (add), ⊙ (dot/Hadamard), ⊗ (multiply/sample), Ⓒ (concat), all thin black strokes.
- **State icons**: 🔥 = trainable / learnable, ❄️ = frozen — placed at the top-right corner of blocks. Always include when the method has frozen parts.
- **Small illustrative icons**: robots (agents), LLM glyphs, globe, speaker/waveform, camera frustums, gears, magnifier — flat, colorful, minimal.
- **Real data**: input and output images/videos/3D renders as rounded-corner thumbnails at the **left edge (inputs)** and **right edge (outputs)**. Video = 3–4 stacked or filmstrip frames. 3D = rendered mesh/point cloud/Gaussians on white.

## 4. Arrows & lines

- Default arrows: 1.5–2 px, dark gray `#555` or black, solid, orthogonal (elbow) routing preferred; curves only for global loops/feedback.
- **Elbow corners must be rounded**, like the corners of the rounded boxes — never a sharp 90° turn. Use a corner radius of ~8–12 px at 2000 px width (about the same as the block radius). In SVG, draw each turn as a quarter arc, e.g. `M x0 y0 H x1-r Q x1 y0 x1 y0+r V y2` (or `A r r 0 0 1`); in draw.io/PPT set the connector to rounded.
- **Leave a straight run before the arrowhead.** After the last turn, the line must continue straight for at least ~3× the arrowhead length (≈ 24–40 px at 2000 px width) before the head. Never put the arrowhead right at the corner — it looks abrupt. If the space is too tight, move the turn earlier (farther from the target) rather than shortening the final segment.
- **Ports on a box are evenly spaced and symmetric.** When N arrows enter or leave the same side of a box: (1) the gaps between neighboring arrows are equal, and (2) the margin from the first arrow to its end of that side equals the margin from the last arrow to the other end. Default: place arrow i at i/(N+1) of the side length, so one arrow sits exactly at the center and two arrows sit at 1/3 and 2/3. This applies to the left/right sides (top and bottom margins equal) and to the top/bottom sides (left and right margins equal). Measure along the straight part of the side, not including the rounded corners.
- **Route lines through the middle of gaps.** A connector segment that runs through the space between two boxes or panels sits on the centerline of that gap: equal clearance to the elements on both sides. This includes the bends of elbow arrows. Never hug one box's edge. Each segment runs through a gap; it does not run between a box and the canvas edge. When several parallel lines share one gap, spread them evenly across it and keep the outer margins equal (same rule as ports).
- **Big flow arrows** between stages: thick, filled, pastel (lavender `#C8B4F5`, light blue, peach) block arrows — a signature element.
- **Color-coded streams**: when there are ≥2 information streams, color each (e.g. blue, red, orange, purple) and explain in the legend.
- **Dashed**: gradient flow / feedback / optional / inference-only paths; dashed boxes group sub-components or mark zoom regions. Red dashed box = the key novel component.
- Arrowheads: small, filled triangles.

## 5. Typography

- **Font**: SF Pro (user's default for HTML/PPT); fallback Helvetica Neue / Arial. Math: serif italic (Times / Latin Modern / KaTeX) — `$\mathcal{E}_{image}$`, `$F_V$`, `$\mathcal{L}_{orth}$`, `$z_t$`.
- Hierarchy (at ~2000 px canvas width):
  - Panel titles: 22–28 px, **bold**, dark or panel-hue colored.
  - Block labels: 16–20 px, medium/regular, centered.
  - Annotations / tensor symbols: 14–18 px, math italic.
  - Legend: 13–15 px.
- Method name may appear as a stylized colored wordmark/logo inside the figure.
- Losses in colored text or in a pink/red rounded box: `$\mathcal{L}_{PPS}=\|v_\theta - v\|$`.
- **No gray text.** All text is near-black `#111111`–`#232323`, or the accent color of the panel it sits in (e.g. `#375FC3` in a blue panel, `#AF0505` for a loss or a red path label). Don't use `#666`/`#888`-style gray to mark text as secondary. If text feels secondary, delete it instead (see the next rules).
- Keep text short; no sentences except in example prompts/captions shown in quote boxes (italic, rounded box, light gray).
- **Don't write what the picture already shows.** If color, shape, position, an icon or an arrow already conveys something, don't add a text label for it. Examples: no "input" / "output" captions on thumbnails at the edges, no "trainable" / "frozen" next to 🔥/❄️, no "flow" or "concat" on arrows and operators, no subtitles that restate a block's name, no column headers over self-explanatory swatches. Every remaining piece of text should name something the viewer could not otherwise identify (module names, math symbols, losses). When in doubt, delete it.

## 6. Things to avoid

- Saturated, rainbow-heavy fills; dark backgrounds; gradients everywhere.
- Sharp-cornered boxes, 3D bevels, heavy shadows, clip-art.
- Arrows crossing without purpose; inconsistent arrow weights.
- Unlabeled symbols — every math symbol, icon and arrow type must appear in a legend or label.
- Text smaller than ~1/100 of canvas width (unreadable when printed at column width).

## 7. Workflow when drawing a new figure

1. Extract from the user (or paper) the modules, data flow, which parts are trainable/frozen, and the novel component.
2. Pick the macro layout from §1 (default: left→right with a bottom detail row if there is a key sub-module).
3. Assign one hue per module from §2; reserve the most distinctive treatment (red dashed box / pink panel / saturated arrow) for the novel component.
4. Place real input/output thumbnails at the edges (ask for image paths or use placeholders).
5. Draw blocks, tokens, operators, 🔥/❄️, then arrows; add legend.
6. For HTML/SVG output: build with inline SVG or absolutely positioned divs at a fixed 2000×900 canvas, SF Pro + KaTeX, then export PNG/PDF via headless Chrome/Playwright and `Read` the PNG to self-check alignment, overlaps and readability before handing over.
7. When critiquing an existing figure, check it against §2–§6 and give concrete fixes (hex values, sizes).

