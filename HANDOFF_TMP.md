# Handoff Temporary Context

## 1. Current Status
- Date/time: 2026-05-04 16:28:22 +09:00
- Branch: `sub`
- Git status before this handoff refresh:
  - `docs/MiniGgotchi_PRD.md` modified
  - `docs/MiniGgotchi_schema.sql` untracked
- Repository path: `C:\Users\user\.gemini\antigravity\scratch\Refresheet_Prj`
- Encoding note: keep this file ASCII-friendly where possible so future agents can read it reliably in PowerShell.

## 2. Latest User Request
The user provided a baseline SQL schema and then clarified:

- Cloudflare DB has already been created.
- Cloudflare DB ID: `5c560a75-93a5-4414-88fc-0bd8e9ff4e26`
- The tables have already been created using the user-provided SQL.

The correct repo response is to document the applied Cloudflare baseline schema as-is, not to silently replace it with a stronger recommended schema.

## 3. Completed Work
- Read existing `HANDOFF_TMP.md` before work.
- Created `docs/MiniGgotchi_schema.sql`.
- Adjusted `docs/MiniGgotchi_schema.sql` to match the exact applied user-provided baseline schema.
- Added Cloudflare DB ID and baseline schema status to `docs/MiniGgotchi_PRD.md` section 8.
- Documented future migration candidates separately in the SQL file comments.
- Refreshed this handoff file with the latest state and instructions.

## 4. Modified Files
- `docs/MiniGgotchi_PRD.md`
- `docs/MiniGgotchi_schema.sql`
- `HANDOFF_TMP.md`

## 5. Remaining Work
- Commit and push these changes to `sub`.
- Apply the same commit to `main` if the user wants both branches kept aligned, consistent with prior workflow.
- Optional future work: create explicit migration files for indexes, CHECK constraints, report/hidden fields for company tags, and additional foreign keys.

## 6. Important Decisions / Constraints
- Never revert user changes unless explicitly asked.
- Actual file state and `git status` take priority over this handoff text.
- Always run `git status --short --branch` before editing.
- Before finishing a task, remove any existing handoff file and create a new `HANDOFF_TMP.md` with current information.
- Treat these names as possible existing handoff files:
  - `HANDOFF_TMP.md`
  - `.handoff_tmp.md`
  - `tmp_handoff.md`
- The applied DB schema must match what exists in Cloudflare. Do not add constraints or columns to `docs/MiniGgotchi_schema.sql` unless a migration has actually been applied.
- Cloudflare DB ID to preserve in docs: `5c560a75-93a5-4414-88fc-0bd8e9ff4e26`.

## 7. Verification
Commands run:
- `git status --short --branch`
  - Result at start: `## sub...origin/sub`
- `Get-Content -Raw HANDOFF_TMP.md`
  - Result: existing handoff read successfully.
- `Get-Date -Format "yyyy-MM-dd HH:mm:ss zzz"`
  - Result: `2026-05-04 16:28:22 +09:00`
- `git diff --check`
  - Result before handoff refresh: no whitespace errors, only CRLF warnings for Markdown.

Not yet verified:
- Final `git status` after this handoff refresh.
- Commit/push status for the schema documentation changes.

## 8. Recommended Next Step
- Run `git status --short --branch`.
- Run `git diff --check`.
- Commit `docs/MiniGgotchi_PRD.md`, `docs/MiniGgotchi_schema.sql`, and `HANDOFF_TMP.md`.
- Push to `sub`.
- Cherry-pick the commit to `main` and push `main` if keeping both branches aligned.

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
