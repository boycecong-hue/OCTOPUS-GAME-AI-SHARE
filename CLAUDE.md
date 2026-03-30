# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository is a slide deck for an internal AI coding tech talk, implemented as a lightweight Markdown-driven web presentation rather than a traditional PPT.

- `index.html` is the entire app shell: layout, styling, navigation, Markdown rendering, Mermaid rendering, Prism highlighting, and client-side section loading.
- `sections/*.md` are the slide sources. Each file maps to one navigation item and is fetched dynamically by `loadSection()` in `index.html`.
- `docs/superpowers/specs/2026-03-26-ai-coding-sharing-design.md` is the source design brief for the presentation structure and messaging.
- `start_sharing.sh` and `ai-share.sh` are convenience scripts for serving the deck locally over `python3 -m http.server`.

## Common Commands

### Run locally

Preferred manual server:

```bash
python3 -m http.server 8000
```

Open:

```bash
http://localhost:8000/index.html
```

Convenience scripts:

```bash
bash start_sharing.sh
bash ai-share.sh
```

Notes:
- `start_sharing.sh` serves the current directory and opens the browser on macOS.
- `ai-share.sh` does the same, but it contains a hardcoded absolute project path; update it if the repo is moved.

### No formal build step

This project is static HTML/JS/Markdown. There is no package manager, bundler, or compile step in the current repo.

### No formal test or lint setup

There is currently no test runner, linter, or formatter configured in this repository.

## Architecture

### Presentation runtime

`index.html` is the runtime for the whole presentation:

- Defines the fixed sidebar navigation and main content area.
- Loads section Markdown files from `./sections/${fileName}.md` at runtime.
- Uses an in-memory `cache` object to avoid refetching already opened sections.
- Converts Markdown to HTML with `marked`.
- Detects fenced `mermaid` blocks and wraps them so Mermaid can render diagrams after content injection.
- Highlights code blocks with Prism.
- Handles loading and error states entirely in the browser.

Because the app is fetch-based, it must be served over HTTP; opening `index.html` directly as a `file://` page will break section loading in normal browser setups.

### Content model

The actual talk content lives in Markdown, split by chapter:

- `sections/00-cover.md` through `sections/06-future.md` hold the presentation narrative.
- The sidebar in `index.html` is manually kept in sync with these section filenames.
- If you add, rename, or reorder a section, update both the Markdown file set and the navigation `onclick` bindings in `index.html`.

### External dependencies

The deck relies on browser-loaded CDN assets rather than vendored dependencies:

- `marked` for Markdown parsing
- `mermaid` for diagrams
- `prismjs` for code highlighting

This means presentation rendering depends on network access unless those assets are replaced with local copies.

## Important Project Conventions

- Keep the repo lightweight and static-first; avoid introducing a build system unless the user explicitly asks for one.
- Treat `sections/*.md` as source-of-truth for talk content and `index.html` as the presentation engine.
- Preserve the current “single shell + Markdown chapters” structure when making content or styling changes.
- When editing Mermaid-heavy sections, verify both the raw Markdown and rendered browser output, since rendering happens only after client-side injection.
- Inline HTML inside Markdown is intentionally used for layout-rich slides such as the cover page; do not simplify it away unless requested.

## Key Files

- `index.html`: app shell and all client-side behavior
- `sections/`: slide content split by chapter
- `docs/superpowers/specs/2026-03-26-ai-coding-sharing-design.md`: original presentation design/spec
- `start_sharing.sh`: portable local serve helper
- `ai-share.sh`: local serve helper with hardcoded project path
