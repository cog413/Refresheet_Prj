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
