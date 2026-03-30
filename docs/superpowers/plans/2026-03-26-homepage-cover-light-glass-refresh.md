# Homepage Cover Light Glass Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将首页封面从深色未来感快速切换为白底局部渐变、浅色玻璃感海报风格，同时保留现有内容结构。

**Architecture:** 保持 `sections/00-cover.md` 结构基本不变，仅在 `index.html` 中快速替换封面主题变量与 `cover-*` 样式，使封面从深色大块 Hero 转为浅色、通透、柔和发光的玻璃感主卡片。实现范围只限首页封面相关样式，不改站点结构和章节逻辑。

**Tech Stack:** Vanilla HTML, CSS, JavaScript, Marked

---

## File Map

- Modify: `index.html`
  - 责任：将封面色板、背景、卡片、标签和文字样式从深色方案改成浅色玻璃感方案。
- Keep: `sections/00-cover.md`
  - 责任：沿用当前 Hero 结构，只依赖新的浅色样式渲染。

## Validation Strategy

- 本地运行：`python3 -m http.server 8000`
- 页面检查：`http://localhost:8000/index.html`
- 成功标准：封面不再黑压压；整体更亮、更轻、更清爽；标题仍清晰；信息卡更像浅色玻璃卡片。

### Task 1: Convert cover styles to light glass theme

**Files:**
- Modify: `index.html`

- [ ] **Step 1: Replace dark cover variables with light theme variables**

将 `:root` 中封面变量替换为浅色方案，例如：

```css
--cover-bg-start: #fdfdff;
--cover-bg-end: #eef6ff;
--cover-grid: rgba(99, 102, 241, 0.06);
--cover-glow-primary: rgba(129, 140, 248, 0.18);
--cover-glow-secondary: rgba(103, 232, 249, 0.16);
--cover-text: #1e293b;
--cover-muted: #5b6b83;
--cover-panel: rgba(255, 255, 255, 0.72);
--cover-border: rgba(148, 163, 184, 0.22);
```

- [ ] **Step 2: Replace the `.cover-hero` block with a light poster-style card**

将 `.cover-hero` 调整为浅色玻璃海报风，例如：

```css
.cover-hero {
    position: relative;
    isolation: isolate;
    overflow: hidden;
    padding: 72px;
    border-radius: 36px;
    background:
        radial-gradient(circle at 12% 18%, var(--cover-glow-primary), transparent 28%),
        radial-gradient(circle at 88% 20%, var(--cover-glow-secondary), transparent 24%),
        linear-gradient(180deg, rgba(255, 255, 255, 0.95), rgba(241, 248, 255, 0.92));
    color: var(--cover-text);
    border: 1px solid rgba(255, 255, 255, 0.72);
    box-shadow: 0 24px 80px rgba(148, 163, 184, 0.18);
}
```

- [ ] **Step 3: Soften the decorative overlay instead of using dark grid pressure**

将 `.cover-hero::before` 改为更轻的浅色装饰层，保留科技感但减少压迫感，例如：

```css
.cover-hero::before {
    content: "";
    position: absolute;
    inset: 0;
    background:
        linear-gradient(var(--cover-grid) 1px, transparent 1px),
        linear-gradient(90deg, var(--cover-grid) 1px, transparent 1px);
    background-size: 36px 36px;
    mask-image: radial-gradient(circle at center, black 40%, transparent 88%);
    opacity: 0.45;
    pointer-events: none;
    z-index: -1;
}
```

- [ ] **Step 4: Convert eyebrow, kicker, title, manifesto to light-theme typography**

将以下类改为浅色高阶科技感：

```css
.cover-eyebrow {
    background: rgba(255, 255, 255, 0.68);
    color: #4f46e5;
    border: 1px solid rgba(129, 140, 248, 0.18);
}

.cover-kicker {
    color: #6366f1;
}

.cover-title {
    color: #1e293b;
}

.cover-title-accent {
    background: linear-gradient(135deg, #4f46e5 0%, #0ea5e9 48%, #22c55e 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-shadow: none;
}

.cover-manifesto {
    color: var(--cover-muted);
}
```

- [ ] **Step 5: Convert meta panel and tags to light glass cards**

将 `.cover-panel`、`.cover-meta-label`、`.cover-meta-value`、`.cover-tag` 改为浅色玻璃卡风格，例如：

```css
.cover-panel {
    background: var(--cover-panel);
    border: 1px solid var(--cover-border);
    box-shadow: 0 12px 40px rgba(148, 163, 184, 0.12);
}

.cover-meta-label {
    color: #64748b;
}

.cover-meta-value {
    color: #0f172a;
}

.cover-tag {
    background: rgba(255, 255, 255, 0.82);
    color: #334155;
    border: 1px solid rgba(148, 163, 184, 0.18);
}
```

- [ ] **Step 6: Keep responsiveness, only soften spacing if needed**

保留现有响应式结构，只在必要时微调 `padding`、`border-radius` 和字号，不改断点策略。

### Task 2: Validate the light refresh

**Files:**
- Modify: `index.html`

- [ ] **Step 1: Run local preview server if not already running**

Run:

```bash
python3 -m http.server 8000
```

- [ ] **Step 2: Check the updated homepage visually**

Open:

```text
http://localhost:8000/index.html
```

Expected:

```text
[ ] 首页整体变亮，不再黑压压
[ ] Hero 仍有设计感，但更轻更通透
[ ] 信息卡呈现浅色玻璃感
[ ] 标题仍然是第一视觉中心
```

- [ ] **Step 3: Confirm scope stays minimal**

Verify only this file changed:

```text
index.html
```

Expected: `sections/00-cover.md` 不需要再次重写。
