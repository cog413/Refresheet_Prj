# Refresheet Multi-Agent Orchestration

## 1. Philosophy

This file defines the runtime orchestration protocol for all AI agents.

It does NOT replace:
- AGENT_GUIDELINES.md
- HANDOFF.md
- chat_log.md

Priority order:
1. AGENT_GUIDELINES.md
2. HANDOFF.md
3. ORCHESTRATION.md

All agents:
- Gemini
- Claude
- Codex
- GPT
- future agents

must follow the same orchestration protocol.

## 2. Default Runtime Mode

Default mode = Orchestrated Mode.

Roles:

- Gemini
  = Orchestrator / PM / Final QA

- Claude
  = Analyst / Planner / Reviewer

- Codex
  = Executor / Tester

- User
  = Final Approver

## 3. Standard Workflow

1. User request arrives
2. Gemini interprets the request
3. If ambiguous:
   - Gemini MUST ask clarification questions first
4. If clear:
   - Gemini creates analysis task files in `.agent/tasks/{timestamp}-{slug}/`
5. Claude analyzes via `scripts/orchestrator.py`:
   - impact scope
   - target files
   - architecture constraints
   - execution plan
6. Claude creates Codex execution prompt file
7. Codex executes ONLY within approved scope:
   - Use `scripts/orchestrator.py` for logic generation
   - Use internal tools for file writing
8. Codex runs:
   - test
   - build
   - typecheck
9. Gemini performs final QA/review
10. User approves
11. Optional commit/push/deploy

## 4. Orchestration Backend Protocol

The Orchestrator delegates tasks to external agents using a unified interface:

- **Primary (Default)**: Logged-in external CLI subprocess orchestration (uses local `claude` and `codex` commands).
- **Secondary (Optional)**: Direct vendor API bridge (requires `ANTHROPIC_API_KEY` or `OPENAI_API_KEY`).
- **Command**: `python scripts/orchestrator.py <task_type> <prompt_file> --agent <claude|codex>`
- **Configuration**: Managed via `.agent/config.json`.
- **Logs**: `stdout`, `stderr`, and `exit_code` are strictly logged per agent in the task directory.

## 4. Hard Rules

- Claude does NOT modify code unless explicitly requested
- Gemini does NOT modify code during final QA
- Codex is the primary code editor
- Codex must stay within Claude plan scope
- No unrelated refactors
- No architecture rewrites without approval
- No auto-merge
- No auto-deploy
- No auto-push
- No direct user spam confirmations from worker agents

## 5. Token Runtime System

Tokens are NOT model features.
They are project runtime commands.

All agents must interpret them consistently.

### `#SOLO#`

Single-agent mode.

Behavior:
- No orchestration
- Current agent works alone
- No planner/reviewer routing
- Still obey:
  - AGENT_GUIDELINES.md
  - HANDOFF.md
- Must ask clarification if ambiguous

Use case:
- quick fixes
- isolated edits
- direct debugging

### `#ORCH#`

Standard orchestration mode.

Behavior:
- Use Gemini → Claude → Codex → Gemini flow
- Use approval queue batching
- Aggregate confirmations

### `#PLAN#`

Planning-only mode.

Behavior:
- No code modification
- No patch generation
- Produce:
  - impact analysis
  - file targets
  - risks
  - implementation plan
  - Codex execution prompt

### `#EXEC#`

Execution-only mode.

Behavior:
- Requires existing approved plan
- Modify only planned files/scope
- No architecture changes
- Run tests/build/typecheck

### `#REVIEW#`

Review-only mode.

Behavior:
- Review diff only
- No direct code modification
- Check:
  - overengineering
  - regression risk
  - unrelated edits
  - LLM.md violations
  - architectural conflicts

### `#CHCK#`

Real verification mode.

Behavior:
- Must verify actual rendering/runtime/preview behavior
- Do NOT infer completion only from reading code
- Use browser/runtime checks if available

Must remain compatible with existing HANDOFF.md #CHCK# policy.

### `#SMCP#`

Sub/Main Commit, Push & Deploy workflow.

Meaning:
1. Commit changes to main
2. Push main
3. Checkout sub
4. Merge main into sub
5. Push sub
6. Return to main
7. Deploy (`wrangler pages deploy .`)

Rules:
- Saying `#SMCP#` IS the explicit user approval for all seven steps, including deploy — no separate per-step confirmation is needed once invoked
- Summarize changed files first
- Require successful build/test verification first (e.g. `npm run test:static`)
- Stop on merge conflict
- Report conflicts instead of improvising
- `git checkout --theirs <file>` allowed only when main is clearly canonical
- Deploy runs only after main and sub are both pushed cleanly; if deploy fails, report the error and stop rather than retrying blindly

Must follow HANDOFF.md Branch Strategy.

## 6. Approval Queue System

Worker agents must NOT repeatedly interrupt the user.

Instead:
- approval requests are aggregated

Create:
.agent/approval-queue.json

Format:

[
  {
    "agent": "codex",
    "type": "file_write",
    "risk": "low",
    "summary": "fix fruit landing logic",
    "files": ["src/..."],
    "recommendation": "approve"
  }
]

### Auto-approved actions

- file reads
- grep/search
- git status/log
- diff generation
- typecheck
- tests
- build without modifications

### Approval-required actions

- file modifications
- dependency changes
- config changes
- migrations
- deletions
- commit/push
- deploy

### Always-manual actions

- DB schema changes
- auth/security/payment logic
- package.json changes
- wrangler/cloudflare config
- production deploy
- major refactors

## 7. Task State System

Create:
.agent/tasks/

Each task:
.agent/tasks/{timestamp}-{slug}/

Files:
- request.md
- orchestrator-plan.md
- claude-analysis.md
- codex-result.md
- final-review.md
- status.json

Example status.json:

{
  "mode": "orchestrated",
  "orchestrator": "gemini",
  "analyst": "claude",
  "executor": "codex",
  "status": "running",
  "merge_ready": false
}

## 8. Failure / Token Exhaustion

Agents may fail or hit token limits.

Rules:
- never silently continue
- preserve partial outputs
- update status.json
- Gemini decides fallback routing
- Claude failure:
  Gemini may perform lightweight fallback review
- Codex failure:
  stop and inspect diff before retry
- failed tasks cannot commit/push/deploy

## 9. Branch / Deploy Safety

Must remain compatible with HANDOFF.md branch flow.

Never:
- auto merge
- auto push
- auto deploy

without explicit user approval.

## 10. Read Order

All agents must read in this order:

1. AGENT_GUIDELINES.md
2. HANDOFF.md
3. ORCHESTRATION.md
4. chat_log.md
5. target files

Never assume memory is correct without checking files.