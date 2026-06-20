# Refresheet Project — Claude Code Guide

## Project Overview

Browser-based Excel disguise app with hidden games and rest features.
Stack: Vanilla JS (ES modules) + Cloudflare Pages + Cloudflare Workers (D1).
No build system — served as static files.

Entry: `index.html` → `src/main.js` → game/feature modules.

---

## Directory Structure

```
Refresheet_Prj/
├── index.html               # App shell (Korean UI — spreadsheet disguise)
├── style.css                # All styles: Excel shell, games, dark mode, pets (3,500+ lines)
├── src/
│   ├── main.js              # Entry point — imports and initializes all modules
│   ├── layout/              # Excel grid, tab switching, dark mode, formula bar
│   ├── stealth/             # Boss key (Escape to hide app)
│   ├── auth/                # Google OAuth state, user settings
│   ├── games/
│   │   ├── sudoku/          # Sheet1
│   │   ├── game2048/        # Sheet2 (logic.js / ui.js / index.js)
│   │   ├── typing/          # Typing game
│   │   ├── newgame/         # New game slot
│   │   └── gameRankingTable.js
│   ├── pet/                 # miniPet.js (visual), petEngine.js (conversation)
│   ├── patties/             # Pattie world: sprite, roaming, physics, economy
│   ├── kpi/                 # KPI display (Focus / Endurance / Care indices)
│   ├── ranking/             # Ranking tabs and display
│   ├── review/              # Review sheet feature
│   ├── onboarding/          # First-run onboarding flow
│   ├── minime/              # Minime sheet setup
│   ├── ui/                  # Login popup, alert popup
│   └── worker/
│       ├── index.js         # Cloudflare Worker: Google OAuth, D1, API routes (2,170 lines)
│       └── cron.js          # Cloudflare Cron Worker
├── public/
│   ├── assets/
│   │   ├── corgi/           # Mong sprite sheets (PNG) + manifest.json  ← production sprites live here
│   │   ├── kitty/           # Cabul sprite sheets + manifest.json
│   │   ├── apple/           # Apple sprites
│   │   └── static-site/     # Static page images (SVGs, referral mockup)
│   └── refresheet-static.css
├── docs/
│   ├── Refresheet_context.md
│   ├── migrations/          # D1 SQL migrations (001–015) — wrangler migrations_dir
│   ├── imports/
│   │   └── typing/          # Executed SQL for typing game content import (history only)
│   └── *.md                 # PRD, schema, roadmap, etc.
├── data/
│   ├── seeds/
│   │   └── sudoku_bulk_seed.sql   # Bulk sudoku seed (NOT a migration — do not put in docs/migrations/)
│   └── typing/
│       └── 한글타자_문제은행_260511.csv  # Korean typing game source data
├── scripts/
│   ├── import_tools/
│   │   └── typing/          # Import scripts for typing content (reference for EN version)
│   │       ├── generate_typing_import_sql.js
│   │       ├── run_typing_import.js
│   │       └── run_typing_import.ps1
│   └── *.js / *.mjs         # Pattie asset scripts, sudoku fetch/seed scripts
├── functions/
│   └── api/[[path]].js      # Cloudflare Pages Functions routing
└── tests/
    └── qa-preview.spec.js   # Playwright QA tests
```

---

## Key Rules

### Folder conventions
- `docs/migrations/` — D1 schema migrations only. wrangler reads this directory. Do NOT put seed or bulk-import SQL here.
- `data/seeds/` — bulk seed SQL (e.g. sudoku). Run manually, not via wrangler migrate.
- `data/typing/` — source CSV data for typing game content.
- `docs/imports/typing/` — historical record of executed import SQL. Not re-runnable.
- `scripts/import_tools/typing/` — reusable scripts for future content imports (e.g. EN typing game).
- `public/assets/corgi/` — production Mong sprite sheets. These are Aseprite exports with 1px padding; do not modify.

### .gitignore
Currently tracked exclusions: `.wrangler/`, `node_modules/`, `debug.log`, `chat_log.md`, `test-results/`, `.agent/tasks/`

### Console logging
- `src/patties/` — conditional debug logs gated by `isSnackDebugEnabled()`. Leave as-is.
- `src/pet/miniPet.js`, `src/worker/index.js` — `console.warn` for error handling. Leave as-is.
- Do not add new freestanding `console.log` calls.

### Pending decisions
- `src/worker/index.js:551-555` — legacy `type_b → dog` character mapping. Do NOT remove without first checking DB for active `type_b` users. This is a data migration concern, not a code cleanup.

---

### Static content regression guard
- Do not wholesale rewrite `public/*.html` pages for copy, logo, or SEO edits. Preserve existing anchors, mockups, scripts, and feature-specific sections unless removal is explicitly requested.
- `public/faq.html` must keep the friend referral FAQ section at `#friend-referral`. It is linked by Kitty lock help via `/faq#friend-referral`.
- Keep the referral FAQ mockup hooks intact: `referral-card`, `mock-window`, `mock-mouse`, `mock-settings-modal`, `mock-referral-input`, `mock-btn-referral-save`, and `mock-success-screen`.
- After touching `public/faq.html`, `public/refresheet-static.css`, or `src/minime/minimeSetup.js`, run `npm run test:static`.

---

## English Version (Future)

The EN version will be a separate domain/repo forked from this codebase.
Korean strings are hardcoded throughout (14 JS files, `index.html`, `public/*.html`).
Before forking: confirm approach — simple fork vs. i18n layer.

When importing EN typing content, use `scripts/import_tools/typing/` as the template
(Korean CSV at `data/typing/` is the structural reference).
