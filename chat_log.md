# Chat Log (Auto-Managed)

---

### [2026-05-23] (CLI: gemini)

**1. 목표**
- Refresheet_Prj 프로젝트에 멀티 에이전트 오케스트레이션 시스템 구축.
- 기존 파일(HANDOFF.md, AGENT_GUIDELINES.md, chat_log.md, refresheet.context) 체계를 유지하며 "오케스트레이션 레이어"를 얹음.
- 토큰 기반 모드 전환, approval batching 등 중앙 제어 시스템 도입.
- **신규**: 파이썬 브릿지를 통해 실제 외부 LLM(Anthropic Claude, OpenAI GPT)을 호출하는 리얼 멀티 에이전트 환경 구축.

**2. 현재 상태**
- `AGENT_GUIDELINES.md`에 Multi-Agent Coordination 룰 추가.
- `HANDOFF.md`에 Multi-Agent Rules (승인 필요 조건, `#SMCP#` 연동 등) 추가.
- `ORCHESTRATION.md` 생성 및 표준 워크플로우, 토큰 시스템 정의.
- `.agent/bridges/llm_bridge.py` (신규): Anthropic/OpenAI API 호출용 파이썬 스크립트.
- `.agent/approval-queue.json` 생성.
- `.agent/tasks/` 디렉터리 생성.

**3. 문제**
- 내부 에이전트 인스턴스만으로는 진정한 멀티 벤더 지능 활용에 한계가 있음.
- 모델별 고유 강점을 실제 API 수준에서 결합할 필요가 있음.

**4. 시도한 것**
- `llm_bridge.py`를 작성하여 `ANTHROPIC_API_KEY` 및 `OPENAI_API_KEY` 환경 변수를 사용한 실제 API 통신 기능 구현.
- 파일 기반 핸드오프 메커니즘을 도입하여 쉘 명령줄 길이 제한 및 이스케이핑 이슈 해결.
- `ORCHESTRATION.md`를 업데이트하여 분석(Claude) 및 계획 단계에서 반드시 외부 브릿지를 사용하도록 규정.

**5. 해결 / 인사이트**
- Gemini(Orchestrator)가 쉘 명령을 통해 진짜 Claude와 GPT를 호출하고 결과를 파일로 주고받는 "리얼 멀티 에이전트 팀" 구조가 완성됨.

**6. 반영 필요 사항 (중요)**
- 이후 `#ORCH#` 작업 시 `python .agent/bridges/llm_bridge.py`를 사용하여 에이전트 역할을 위임함.
- API 키가 환경 변수에 올바르게 설정되어 있어야 함.

---

### [2026-05-23] (CLI: gemini)

**1. 목표**
- 오케스트레이션 백엔드를 Direct API 방식에서 로컬 CLI 서브프로세스 방식으로 전환.
- API 키 없이도 이미 로그인된 `claude` 및 `codex` CLI를 활용할 수 있도록 구조 개선.

**2. 현재 상태**
- `.agent/config.json`: 백엔드 설정(cli/api) 및 에이전트별 명령어 정의.
- `scripts/orchestrator.py`: CLI 호출 및 API 브릿지를 통합 관리하는 중앙 제어 스크립트 구현.
- `ORCHESTRATION.md`: CLI 기반 오케스트레이션을 기본 프로토콜로 업데이트.

**3. 문제**
- 사용자의 환경에 `ANTHROPIC_API_KEY` 등이 설정되어 있지 않아 기존 API 브릿지 방식이 동작하지 않음.
- 윈도우 커맨드라인 길이 제한(8191자) 이슈 대응 필요.

**4. 시도한 것**
- `scripts/orchestrator.py`를 통해 `subprocess.run` 기반의 CLI 호출 로직 구현.
- `stdin_fallback` 옵션을 통해 긴 프롬프트 처리 지원.
- `stdout`, `stderr`, `exit_code`를 개별 파일 및 `status.json`에 기록하여 추적성 강화.
- `--dry-run` 모드를 지원하여 실제 실행 전 명령어를 확인할 수 있게 함.

**5. 해결 / 인사이트**
- 별도의 API 키 관리 없이도 로컬에 설치된 CLI 도구들을 오케스트레이션 레이어에서 안정적으로 사용할 수 있게 됨.

**6. 반영 필요 사항 (중요)**
- 이제 모든 에이전트 호출은 `python scripts/orchestrator.py`를 경유함.
- API 방식은 `config.json` 수정 또는 `--backend api` 옵션을 통해 선택적으로 사용 가능.
---

### [2026-06-04] (CLI: codex)

**1. Goal**
- Prevent repeat regressions from the ReadMe grid and Pattie terrain/snack coordinate fixes.

**2. Changes**
- Updated `HANDOFF.md` with ReadMe grid rules: `.rm-sheet` owns the grid, needs explicit paintable dimensions, and `.rm-block` must stay transparent.
- Updated `HANDOFF.md` with Pattie terrain cautions: use `chartSurfaceModel.js`, group bars by `mp-bar-pair`, keep `apple_idle..png`, and tune snack speed only through snack-specific constants.
- Updated `AGENT_GUIDELINES.md` with CSS visual regression checks: compare recent git history and verify computed styles before patching backgrounds/grids.

**3. Lessons**
- The ReadMe grid disappeared because `.rm-block` became opaque and `.rm-sheet` had zero width due to absolute-positioned children.
- Broad wrapper backgrounds hide spreadsheet grid lines. Content panels can be opaque; positioning containers should usually stay transparent.
- Pattie pet/snack coordinate fixes must stay centralized. Independent magic-number patches reintroduce 1-4px drift.

---

### [2026-06-05] (CLI: codex)

**1. Goal**
- Update FAQ and File tab copy for company ranking and feedback guidance.

**2. Changes**
- Updated FAQ company ranking wording from email-domain aggregation to registered company-name aggregation.
- Updated FAQ feedback wording to refer to Refresheet and mention the main Excel `보기` tab.
- Updated the File tab main intro copy to explain Refresheet's purpose and content guide.

**3. Verification**
- Text-only change; verified target strings with `rg`.

---

### [2026-06-05] (CLI: codex)

**1. Goal**
- Adjust login onboarding button layout without changing the surrounding scene or sheet/grid styling.

**2. Changes**
- Removed the Step 1 company-info `Skip` button and its click binding; the remaining `Next` button stays right-aligned through the existing `.modal-buttons` flex-end rule.
- Swapped Step 2 commute buttons to `Previous` then `Next`.
- Swapped Step 3 employee-name buttons to `Previous` then `Save`.

**3. Verification**
- Ran `node --check src/onboarding/onboarding.js`.

---

### [2026-06-05] (CLI: codex)

**1. Goal**
- Adjust ReadMe sheet vertical block placement without touching X-axis, widths, or restored Excel grid rules.

**2. Changes**
- Updated only ReadMe block Y coordinates in `style.css`: KPI rows 2-9, rank rows 11-20, notes rows 22-27, tab/button guide rows 21-27.
- Slightly adjusted KPI card padding and tab-guide item height to fit the taller blocks.

**3. Verification**
- Browser computed style confirmed `.rm-sheet` still has `1600x640` paintable area, grid background gradients remain active, and `.rm-block` remains transparent.

---

### [2026-06-05] (CLI: codex)

**1. Goal**
- Make the shared Excel grid cover at least through column W and row 32 on every sheet.

**2. Changes**
- Added common `.sheet-view` minimum dimensions of `1840px x 704px` (`A-W`, rows `1-32`).
- Expanded `.rm-sheet` to the same `1840px x 704px` while preserving ReadMe grid ownership and `.rm-block` transparency.
- Restored grid background on `#file-sheet`, which had previously overridden the common sheet grid with a background shorthand.

**3. Verification**
- Browser audit confirmed all measured sheets (`readme`, `mini-pet`, `sudoku`, `newgame`, `game2048`, `typing`, `review`, `file`) have a `.sheet-view` grid area of at least `A-W` and row `32`.
