# Handoff Temporary Context

## 1. Current Status
- Date/time: 2026-05-04 (Asia/Seoul)
- Branch: `sub` (cherry-picked to `main`)
- Git status: clean
- Latest sub commit: `60f5589` / main commit: `5eccc3f`

## 2. Latest User Request
User confirmed items 1-2 were visible but items 3-5 were NOT visible after the previous commit.
Task: find and fix why items 3, 4, 5 were invisible, then commit + push both branches.

## 3. Completed Work
**Root cause found:** The difficulty selector (Sudoku/SDK tab) and grid-size selector (2048 tab) were
injected with `appendChild`, placing them at the BOTTOM of their left panels — below two existing
HTML tables. On typical viewport heights this puts them below the fold and the user doesn't see them.

**Fix:** Changed both injections to `prepend()` so the selectors appear at the TOP of the panel,
immediately visible when the user opens either tab.

Files changed:
- `src/games/sudoku/sudoku.js`: `leftPanel.prepend(buildDifficultySelector())` (was `appendChild`)
- `src/games/game2048/ui.js`: `leftPanel.prepend(buildSizeSelector())` (was `appendChild`)

**All 5 original UX items** from commit `4479b24` remain intact:
1. Title bar: `SneakTime - Refresheet`
2. Tab order: ReadMe / 관리시트 / 2048 / SDK
3. 2048: 4×4/5×5 size selector + game-over modal (HTML already in index.html)
4. Sudoku (SDK): difficulty selector (top of left panel), number highlight, modal Enter/Esc close, score
5. Pet: strain animation + SVG trend chart between bar chart and minimap

## 4. Modified Files (this session)
- `src/games/sudoku/sudoku.js` (prepend fix)
- `src/games/game2048/ui.js` (prepend fix)
- `HANDOFF_TMP.md`

## 5. Remaining Work
- Deploy Cloudflare Worker with `GET /api/games/sudoku/next?difficulty=<1-5>&exclude=<ids>`
  (Worker endpoint; app currently uses offline fallback puzzle — game works without it)
- Apply `docs/migrations/001_user_content_history.sql` to D1 for play-history deduplication
- Verify D1 seed row count:
  `npx wrangler d1 execute db_game_info --remote --command="SELECT COUNT(*) FROM sudoku_puzzles WHERE puzzle_id LIKE 'sudoku_bulk_%';"`

## 6. Important Decisions / Constraints
- Never revert user changes unless explicitly asked.
- Actual file state takes priority over handoff text.
- Run `git status --short --branch` before work.
- `initSudoku()` is async; `main.js` calls it without await — intentional.
- Offline fallback puzzle is intentional — app works without Worker deployed.
- DB columns: `puzzle_id TEXT`, `difficulty TEXT ('1'-'5')`, `puzzle TEXT (81-char)`, `solution TEXT (81-char)`, `is_active INTEGER`.
- Cloudflare DB name: `db_game_info`. DB ID: `5c560a75-93a5-4414-88fc-0bd8e9ff4e26`.
- Before ending work, delete old handoff and create a fresh `HANDOFF_TMP.md`.

## 7. Verification
Verified (this session):
- `node --check` passes on all JS files (no syntax errors)
- `logic.js` module loads correctly in Node.js; `isGameOver` export confirmed
- Local `npx serve` test: JS files served with correct `application/javascript` MIME type
- Git log shows clean push: sub `60f5589`, main `5eccc3f`

Not verified (need browser test):
- Visual confirmation that difficulty selector now appears at top of SDK left panel
- Visual confirmation that size selector appears at top of 2048 left panel
- Pet strain animation fires when pet walks over data rows
- Sudoku score system (number highlight, Enter/Esc modal close, score on win)
- 2048 game-over modal popup when board is full

## 8. Recommended Next Step
1. Open the app in browser, navigate to SDK tab — difficulty selector should now be visible at the
   TOP of the left panel (above the 인사평가일정 and 결재대기 tables).
2. Navigate to 2048 tab — grid-size selector should be at the TOP of the left panel.
3. Navigate to 관리시트 — scroll right in the habitat to see the SVG trend chart.
4. If Cloudflare Pages is connected to the `main` branch, the deployment will trigger automatically.

## 9. Handoff Rule For Next LLM

Follow this protocol exactly:

```text
You are a coding/documentation agent continuing work from a previous LLM.

Core principles:
1. Before starting work, search the current folder for a temporary handoff file.
2. Candidate handoff filenames:
   - HANDOFF_TMP.md
   - .handoff_tmp.md
   - tmp_handoff.md
3. If a handoff file exists, read it first and use it as the starting context.
4. If no handoff file exists, inspect the current repo/file state directly and start from there.
5. If the handoff content conflicts with the actual file state, trust the actual file state.
6. Do not revert user changes unless explicitly asked.

Start-of-work procedure:
1. Run `git status --short --branch`.
2. Read any existing handoff file.
3. Compare the handoff with actual repo state.
4. Follow the user's latest request.
5. Preserve unrelated user work.

End-of-work procedure:
1. Delete any existing handoff file.
2. Create a fresh `HANDOFF_TMP.md`.
3. The new file must include:
   - Current date/time
   - Current branch
   - Git status summary
   - Latest user request
   - Completed work
   - Modified files
   - Remaining work
   - Important decisions/constraints
   - Verification commands and results
   - Recommended next step
   - This full handoff rule

Required `HANDOFF_TMP.md` structure:

# Handoff Temporary Context

## 1. Current Status
- Date/time:
- Branch:
- Git status:
- Workspace notes:

## 2. Latest User Request
Summary:

## 3. Completed Work
-

## 4. Modified Files
-

## 5. Remaining Work
-

## 6. Important Decisions / Constraints
- Never revert user changes unless explicitly asked.
- Actual file state takes priority over handoff text.
- Run `git status --short --branch` before work.
- Before ending work, delete the old handoff and create a fresh `HANDOFF_TMP.md`.

## 7. Verification
Verified:
-

Not verified:
-

## 8. Recommended Next Step
-

## 9. Handoff Rule For Next LLM
The next LLM must read this file first.
When finished, it must delete this file and create a fresh `HANDOFF_TMP.md` with updated context and this same rule.
```
