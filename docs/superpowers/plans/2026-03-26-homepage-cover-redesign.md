# Homepage Cover Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将首页封面从普通分享封面升级为具有未来科技感的发布会级 Hero 开场，同时保持现有 Markdown 驱动架构不变。

**Architecture:** 保持 `index.html` 作为单页运行时，不引入新框架或构建步骤。视觉升级分为两部分：一是在 `index.html` 中补充首页可复用样式与暗色 Hero 支撑，二是在 `sections/00-cover.md` 中重写封面结构与文案层级，让页面通过现有 Markdown 注入流程直接渲染。

**Tech Stack:** Vanilla HTML, CSS, JavaScript, Marked, Mermaid, Prism, Python `http.server`

---

## File Map

- Modify: `index.html`
  - 责任：补充首页专用的可复用视觉类，例如 Hero 容器、背景 glow、panel、tag、系统信息带与暗色封面样式。
- Modify: `sections/00-cover.md`
  - 责任：重写首页内容结构、文案层级与语义块，使用新的通用类而非继续堆积 inline style。
- Reference: `docs/superpowers/specs/2026-03-26-homepage-cover-redesign-design.md`
  - 责任：本次实现的设计依据。

## Validation Strategy

当前仓库没有自动化测试、lint 或构建系统，因此验证以本地运行和人工检查为主：

- 本地运行：`python3 -m http.server 8000`
- 页面检查：访问 `http://localhost:8000/index.html`
- 检查项：封面是否正确渲染、样式是否生效、导航切换是否正常、其他章节未被破坏。

### Task 1: Add reusable cover style primitives

**Files:**
- Modify: `index.html`
- Reference: `docs/superpowers/specs/2026-03-26-homepage-cover-redesign-design.md`

- [ ] **Step 1: Add the failing visual target as a checklist in the plan execution notes**

Use this checklist during implementation review:

```text
[ ] 首页为深色未来科技感，而不是当前浅色普通封面
[ ] 有 Hero 主视觉区
[ ] 有更强的标题层级
[ ] 有系统信息带/Focus 标签
[ ] 不影响其他章节基本阅读
```

- [ ] **Step 2: Read the existing CSS section before editing**

Read and locate the `<style>` block in `index.html`, especially these existing regions:

```html
:root { ... }
body { ... }
#content { ... }
#content h1 { ... }
#content h2 { ... }
```

Expected: confirm current global styles are light-themed and the cover currently depends mostly on inline styles from `sections/00-cover.md`.

- [ ] **Step 3: Add minimal reusable cover variables in `:root`**

Insert variables like these into the existing `:root` block in `index.html`:

```css
--cover-bg-start: #050816;
--cover-bg-end: #0b1530;
--cover-grid: rgba(125, 211, 252, 0.08);
--cover-glow-primary: rgba(99, 102, 241, 0.35);
--cover-glow-secondary: rgba(34, 211, 238, 0.2);
--cover-text: #e5eefb;
--cover-muted: #94a3b8;
--cover-panel: rgba(9, 18, 39, 0.62);
--cover-border: rgba(148, 163, 184, 0.16);
```

Goal: support a dark futuristic cover without changing other sections.

- [ ] **Step 4: Add reusable cover layout classes**

Add CSS classes in `index.html` after the existing markdown style section:

```css
.cover-hero {
    position: relative;
    overflow: hidden;
    padding: 64px;
    min-height: calc(100vh - 120px);
    border-radius: 32px;
    background:
        radial-gradient(circle at 20% 20%, var(--cover-glow-primary), transparent 32%),
        radial-gradient(circle at 85% 30%, var(--cover-glow-secondary), transparent 28%),
        linear-gradient(135deg, var(--cover-bg-start), var(--cover-bg-end));
    color: var(--cover-text);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    box-shadow: 0 24px 80px rgba(2, 6, 23, 0.45);
}

.cover-hero::before {
    content: "";
    position: absolute;
    inset: 0;
    background-image:
        linear-gradient(var(--cover-grid) 1px, transparent 1px),
        linear-gradient(90deg, var(--cover-grid) 1px, transparent 1px);
    background-size: 44px 44px;
    mask-image: radial-gradient(circle at center, black 45%, transparent 90%);
    pointer-events: none;
}

.cover-hero > * {
    position: relative;
    z-index: 1;
}
```

- [ ] **Step 5: Add reusable typography and panel classes**

Add classes like these in `index.html`:

```css
.cover-eyebrow {
    font-family: 'Fira Code', monospace;
    font-size: 0.8rem;
    letter-spacing: 0.28em;
    text-transform: uppercase;
    color: #93c5fd;
    margin-bottom: 24px;
}

.cover-kicker {
    font-size: 1rem;
    letter-spacing: 0.18em;
    text-transform: uppercase;
    color: rgba(226, 232, 240, 0.72);
    margin-bottom: 20px;
}

.cover-title {
    margin: 0;
    font-size: clamp(3.8rem, 8vw, 7rem);
    line-height: 0.9;
    font-weight: 900;
    letter-spacing: -0.05em;
    color: #f8fbff;
}

.cover-title-accent {
    display: block;
    background: linear-gradient(135deg, #f8fbff 10%, #7dd3fc 45%, #818cf8 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.cover-manifesto {
    max-width: 760px;
    margin-top: 28px;
    font-size: 1.2rem;
    line-height: 1.8;
    color: rgba(226, 232, 240, 0.88);
}

.cover-panel {
    backdrop-filter: blur(18px);
    background: var(--cover-panel);
    border: 1px solid var(--cover-border);
    border-radius: 24px;
    box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.05);
}
```

- [ ] **Step 6: Add info-bar and focus-tag classes**

Add classes like these in `index.html`:

```css
.cover-meta {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 20px;
    margin-top: 48px;
    padding: 24px;
}

.cover-meta-label {
    display: block;
    margin-bottom: 10px;
    font-family: 'Fira Code', monospace;
    font-size: 0.72rem;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: rgba(148, 163, 184, 0.88);
}

.cover-meta-value {
    font-size: 1.05rem;
    font-weight: 600;
    color: #f8fbff;
}

.cover-focus-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.cover-tag {
    display: inline-flex;
    align-items: center;
    padding: 8px 12px;
    border-radius: 999px;
    border: 1px solid rgba(125, 211, 252, 0.18);
    background: rgba(15, 23, 42, 0.42);
    color: #dbeafe;
    font-size: 0.9rem;
    line-height: 1;
}
```

- [ ] **Step 7: Add responsive rules for the new cover classes**

Append a small responsive block in `index.html`:

```css
@media (max-width: 980px) {
    main {
        padding: 36px;
    }

    .cover-hero {
        min-height: auto;
        padding: 36px 28px;
    }

    .cover-meta {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 640px) {
    .cover-title {
        font-size: clamp(2.8rem, 16vw, 4rem);
    }

    .cover-manifesto {
        font-size: 1rem;
    }
}
```

- [ ] **Step 8: Manually review the CSS for scope safety**

Check that all new selectors are prefixed with `cover-` and do not overwrite unrelated global styles.

Expected: no selector should target generic elements like `div`, `p`, or all `h1` outside the existing style system.

### Task 2: Rewrite the cover content structure

**Files:**
- Modify: `sections/00-cover.md`
- Reference: `docs/superpowers/specs/2026-03-26-homepage-cover-redesign-design.md`

- [ ] **Step 1: Preserve the core content inventory before rewriting**

Confirm these content items remain present in the new cover:

```text
AI Coding 2026
开发范式演进：从辅助到自主
讲者信息
时间信息
Concepts / CLI Suite / SDLC Workflow
```

- [ ] **Step 2: Replace the current inline-style-heavy cover block with a semantic hero structure**

Replace the current main block in `sections/00-cover.md` with content shaped like this:

```html
<div class="cover-hero">
  <div>
    <div class="cover-eyebrow">OCTOPUS GAME / GALAXY STUDIO / TECH SHARE</div>
    <div class="cover-kicker">AI Coding 2026</div>
    <h1 class="cover-title">
      开发范式演进
      <span class="cover-title-accent">从辅助到自主</span>
    </h1>
    <p class="cover-manifesto">
      欢迎进入智能体驱动的软件工程时代：当 AI 从辅助走向自主，研发闭环正在被重新定义。
    </p>
  </div>

  <div class="cover-panel cover-meta">
    <div>
      <span class="cover-meta-label">Speaker</span>
      <div class="cover-meta-value">丛泊阳</div>
    </div>
    <div>
      <span class="cover-meta-label">Session</span>
      <div class="cover-meta-value">April 2026</div>
    </div>
    <div>
      <span class="cover-meta-label">Focus</span>
      <div class="cover-focus-list">
        <span class="cover-tag">Concepts</span>
        <span class="cover-tag">CLI Suite</span>
        <span class="cover-tag">SDLC Workflow</span>
      </div>
    </div>
  </div>
</div>
```

- [ ] **Step 3: Remove the old decorative lines and markdown agenda list**

Delete these previous patterns from `sections/00-cover.md`:

```html
<div style="display: flex; flex-direction: column; gap: 12px;">
  <div style="height: 4px; width: 40px; background: #e2e8f0; border-radius: 2px;"></div>
  ...
</div>
```

and:

```md
---

### Agenda / 议程
- **Concepts** - 深度解析 Agent, Skill, MCP
- **CLI Suite** - Claude Code & Gemini CLI 实战
- **SDLC 2.0** - 自主研发全链路闭环演示
```

Expected: focus information moves into the system info bar instead of remaining as a list below the hero.

- [ ] **Step 4: Keep the subtitle in declaration style, not descriptive PPT style**

Use one of these two approved wording directions while keeping the same meaning:

```text
欢迎进入智能体驱动的软件工程时代：当 AI 从辅助走向自主，研发闭环正在被重新定义。
```

or

```text
当 AI 从辅助走向自主，软件研发正在进入下一个范式。
```

Expected: the chosen subtitle reads like a manifesto, not a meeting summary.

- [ ] **Step 5: Keep the cover file focused and readable**

After rewriting `sections/00-cover.md`, confirm the file contains only the new hero structure and no leftover inline styling except where absolutely necessary.

Expected: the cover structure is readable at a glance and mostly powered by reusable classes.

### Task 3: Validate rendering and non-cover safety

**Files:**
- Modify: `index.html`
- Modify: `sections/00-cover.md`

- [ ] **Step 1: Start the local static server**

Run:

```bash
python3 -m http.server 8000
```

Expected: output similar to:

```text
Serving HTTP on :: port 8000 (http://[::]:8000/) ...
```

- [ ] **Step 2: Open the presentation in a browser**

Open:

```text
http://localhost:8000/index.html
```

Expected: sidebar loads, cover renders on initial page load.

- [ ] **Step 3: Verify the cover against the design checklist**

Check the rendered cover for these exact outcomes:

```text
[ ] 深色未来科技底色成立
[ ] 主标题成为第一视觉中心
[ ] AI Coding 2026 作为事件名存在
[ ] 副标语更像宣言而非说明文
[ ] Speaker / Session / Focus 变成系统信息带
[ ] Focus 不再以普通议程列表出现
```

- [ ] **Step 4: Verify navigation still works for adjacent sections**

Click and verify these sidebar entries:

```text
01. 愿景与范式演进
02. 术语深度解析
03. 硬核 CLI 三剑客
```

Expected: content still loads normally, layout remains readable, no accidental dark-theme leakage into those sections.

- [ ] **Step 5: Verify mobile-width resilience with browser resizing**

Resize the browser to approximately `980px` and `640px` widths.

Expected:

```text
[ ] Hero padding shrinks cleanly
[ ] Meta area stacks vertically
[ ] Title remains readable without overflow
[ ] Focus tags still wrap instead of overflowing
```

- [ ] **Step 6: Fix only implementation issues found during manual review**

If any problem appears, limit fixes to:

```text
spacing
font size
panel layout
responsive wrapping
color contrast
selector scoping
```

Do not expand scope into redesigning other sections.

### Task 4: Final cleanup and handoff

**Files:**
- Modify: `index.html`
- Modify: `sections/00-cover.md`
- Reference: `docs/superpowers/specs/2026-03-26-homepage-cover-redesign-design.md`

- [ ] **Step 1: Re-read the spec acceptance criteria**

Re-check these requirements from the spec:

```text
第一眼更未来、更高级、更符合 AI Coding 主题
视觉与 Agent / CLI / 新研发范式一致
信息清晰可读
兼容现有 Markdown 驱动结构
```

- [ ] **Step 2: Confirm the final implementation matches the planned scope**

Verify final changes are limited to:

```text
sections/00-cover.md
index.html
```

Expected: no unrelated files changed.

- [ ] **Step 3: Summarize the implementation for handoff**

Use a handoff summary in this shape:

```text
- 首页封面改为深色未来科技 Hero
- 新增可复用 cover 样式类，减少 inline style
- 议程改为 Focus 标签式系统信息带
- 其余章节结构保持不变
```

- [ ] **Step 4: Offer follow-up work without auto-expanding scope**

Offer only these next-step options:

```text
1. 继续统一其他章节的视觉语言
2. 微调首页文案语气
3. 为首页补轻量动态效果
```

Do not start any of them unless explicitly requested.
