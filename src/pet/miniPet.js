// =====================================================
//  miniPet.js - 미니미 (셀구리) 등반 애니메이션 엔진
//  핵심 수정: display:none 상태에서 getBoundingClientRect() 금지
//  → 탭 클릭 시점에 초기화하도록 변경
// =====================================================

const ROW_H     = 25;   // 엑셀 셀 1행 높이 (px) - CSS와 일치
const TABLE_ROWS = 20;  // 실적장표 데이터 행 수
const CHART_BARS = 6;   // 막대그래프 바 개수

const TABLE_DATA = {
    headers: ['부서명', 'Q1', 'Q2', 'Q3', 'Q4'],
    rows: [
        ['전략기획팀', '12,400', '11,200', '14,800', '13,900'],
        ['영업1팀',    '38,200', '41,500', '39,800', '44,200'],
        ['영업2팀',    '29,100', '31,400', '28,700', '33,600'],
        ['마케팅팀',   '8,500',  '9,200',  '11,400', '10,800'],
        ['개발1팀',    '5,200',  '5,800',  '6,100',  '6,700'],
        ['개발2팀',    '4,900',  '5,100',  '5,400',  '5,900'],
        ['디자인팀',   '3,800',  '4,200',  '4,100',  '4,600'],
        ['인사총무팀', '2,100',  '2,300',  '2,200',  '2,400'],
        ['재무회계팀', '1,800',  '1,900',  '2,100',  '2,000'],
        ['구매팀',     '6,700',  '7,100',  '6,800',  '7,500'],
        ['물류팀',     '9,300',  '9,800',  '10,200', '11,100'],
        ['고객서비스', '4,400',  '4,600',  '4,800',  '5,200'],
        ['법무팀',     '1,200',  '1,300',  '1,400',  '1,300'],
        ['해외영업팀', '22,800', '24,100', '26,300', '28,900'],
        ['기술지원팀', '3,600',  '3,900',  '4,100',  '4,300'],
        ['R&D팀',      '7,200',  '7,800',  '8,100',  '8,700'],
        ['품질관리팀', '2,400',  '2,600',  '2,500',  '2,800'],
        ['안전환경팀', '1,600',  '1,700',  '1,800',  '1,900'],
        ['IT인프라팀', '3,100',  '3,400',  '3,600',  '3,800'],
        ['경영지원팀', '2,900',  '3,100',  '3,300',  '3,500'],
    ]
};

const CHART_DATA = [
    { label: 'Q1',  height: 55,  value: '162.3억' },
    { label: 'Q2',  height: 68,  value: '174.1억' },
    { label: 'Q3',  height: 74,  value: '183.5억' },
    { label: 'Q4',  height: 88,  value: '200.3억' },
    { label: '목표', height: 95, value: '210억'   },
    { label: '합계', height: 100, value: '720.2억' },
];

const SPEECHES = {
    idle:      ['...', '(・・ )', '쉿!', '조용히...', '( ˘ ˘ )'],
    climb:     ['낑낑', '영차!', '우웁..', '후우..', '힘들어', '낑!'],
    top:       ['야호!', '정상이다!', '( ˘▽˘)/', '드디어!', '쉬자...'],
    fall:      ['으악!', '미끄러!', '꺄악!', '아이고!', '으아아'],
    celebrate: ['✨', '( ˘▽˘)☆', '최고야!', '성공!'],
};

function getRandom(arr) { return arr[Math.floor(Math.random() * arr.length)]; }

let domBuilt   = false;
let loopActive = false;
let tickTimer  = null;

let climbState = {
    phase: 'table',
    row: 0,
    barIndex: 0,
    barProgress: 0,
};

// ── 외부에서 호출: DOM만 미리 구축하고 루프는 탭 활성화 때 시작 ──

export function initMiniPet() {
    buildHabitatDOM(); // DOM 구조만 생성 (레이아웃 계산 없음)

    // '미니미' 탭 클릭 감지 → 그 때 루프 시작
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', () => {
            if (tab.dataset.sheet === 'mini-pet') {
                // display:block 전환이 완료된 다음 프레임에서 시작
                requestAnimationFrame(() => {
                    requestAnimationFrame(() => {
                        startOrResume();
                    });
                });
            } else {
                pauseLoop();
            }
        });
    });
}

function startOrResume() {
    if (loopActive) return;
    loopActive = true;

    animateBarsIn();

    // 셀구리 위치 초기화 후 등반 시작
    climbState = { phase: 'table', row: 0, barIndex: 0, barProgress: 0 };
    placeAtTableRow(0);
    showSpeech(getRandom(SPEECHES.idle), 1500);
    tickTimer = setTimeout(tickClimb, 2000);
}

function pauseLoop() {
    loopActive = false;
    clearTimeout(tickTimer);
}

// ── DOM 생성 ───────────────────────────────────────────

function buildHabitatDOM() {
    const habitat = document.getElementById('mini-pet-habitat');
    if (!habitat || domBuilt) return;
    domBuilt = true;

    habitat.appendChild(buildTable());
    habitat.appendChild(buildChart());

    // 셀구리 캐릭터
    const pet = document.createElement('div');
    pet.id = 'mini-pet-sprite';
    pet.className = 'mini-pet-sprite';
    pet.innerHTML = `
        <div class="mps-body">
            <div class="mps-antenna"></div>
            <div class="mps-eyes">
                <div class="mps-eye"></div>
                <div class="mps-eye"></div>
            </div>
            <div class="mps-cheeks">
                <div class="mps-cheek"></div>
                <div class="mps-cheek"></div>
            </div>
        </div>
        <div class="mps-feet">
            <div class="mps-foot"></div>
            <div class="mps-foot"></div>
        </div>
    `;

    // 말풍선
    const bubble = document.createElement('div');
    bubble.id = 'mini-pet-bubble';
    bubble.className = 'mini-pet-bubble';

    habitat.appendChild(pet);
    habitat.appendChild(bubble);
}

function buildTable() {
    const wrapper = document.createElement('div');
    wrapper.className = 'mini-habitat-table';

    const headerRow = document.createElement('div');
    headerRow.className = 'mht-row mht-header';
    TABLE_DATA.headers.forEach(h => {
        const cell = document.createElement('div');
        cell.className = 'mht-cell';
        cell.textContent = h;
        headerRow.appendChild(cell);
    });
    wrapper.appendChild(headerRow);

    TABLE_DATA.rows.forEach((row, i) => {
        const rowEl = document.createElement('div');
        rowEl.className = 'mht-row' + (i % 2 === 0 ? ' mht-even' : '');
        row.forEach((cell, j) => {
            const cellEl = document.createElement('div');
            cellEl.className = 'mht-cell' + (j > 0 ? ' mht-num' : '');
            cellEl.textContent = cell;
            rowEl.appendChild(cellEl);
        });
        wrapper.appendChild(rowEl);
    });

    return wrapper;
}

function buildChart() {
    const wrapper = document.createElement('div');
    wrapper.className = 'mini-habitat-chart';

    const title = document.createElement('div');
    title.className = 'mhc-title';
    title.textContent = '분기별 실적 현황 (억원)';
    wrapper.appendChild(title);

    const barsContainer = document.createElement('div');
    barsContainer.className = 'mhc-bars';

    CHART_DATA.forEach((d, i) => {
        const col = document.createElement('div');
        col.className = 'mhc-col';
        col.dataset.barIndex = i;

        const bar = document.createElement('div');
        bar.className = 'mhc-bar';
        bar.style.height = '0%';
        bar.dataset.targetHeight = d.height;

        const val = document.createElement('div');
        val.className = 'mhc-val';
        val.textContent = d.value;

        const label = document.createElement('div');
        label.className = 'mhc-label';
        label.textContent = d.label;

        col.appendChild(val);
        col.appendChild(bar);
        col.appendChild(label);
        barsContainer.appendChild(col);
    });

    wrapper.appendChild(barsContainer);
    return wrapper;
}

// ── 위치 계산: getBoundingClientRect는 시트가 보일 때만 호출 ──

function placeAtTableRow(rowFromTop) {
    const pet = document.getElementById('mini-pet-sprite');
    if (!pet) return;
    // 테이블 헤더(1행) + rowFromTop 번째 행의 top 위치
    // habitat padding-top = 25px (CSS 기준)
    const HEADER_H = ROW_H; // 헤더 1행
    const PADDING_TOP = 25; // .mini-pet-habitat padding-top
    const topPx = PADDING_TOP + HEADER_H + (TABLE_ROWS - 1 - rowFromTop) * ROW_H - 2;
    pet.style.top  = topPx + 'px';
    pet.style.left = '84px'; // padding-left(80px) + 4px
}

function placeAtChartBar(barIndex, progressPct) {
    const pet = document.getElementById('mini-pet-sprite');
    if (!pet) return;

    const habitat = document.getElementById('mini-pet-habitat');
    const chart   = habitat?.querySelector('.mini-habitat-chart');
    if (!chart) return;

    const cols = chart.querySelectorAll('.mhc-col');
    if (!cols[barIndex]) return;

    const col     = cols[barIndex];
    const barEl   = col.querySelector('.mhc-bar');

    const habitatRect = habitat.getBoundingClientRect();
    const colRect     = col.getBoundingClientRect();
    const barRect     = barEl.getBoundingClientRect();

    const barBottom = barRect.bottom - habitatRect.top;
    const barHeight = barRect.height;
    const targetTop = barBottom - (barHeight * progressPct / 100) - 20;

    pet.style.top  = targetTop + 'px';
    pet.style.left = (colRect.left - habitatRect.left + colRect.width / 2 - 10) + 'px';
}

function animateBarsIn() {
    document.querySelectorAll('#mini-pet-habitat .mhc-bar').forEach((bar, i) => {
        const target = bar.dataset.targetHeight;
        bar.style.height = '0%';
        setTimeout(() => {
            bar.style.transition = 'height 0.8s ease-out';
            bar.style.height = target + '%';
        }, i * 130);
    });
}

// ── 말풍선 ─────────────────────────────────────────────

function showSpeech(text, duration = 1200) {
    const bubble = document.getElementById('mini-pet-bubble');
    const pet    = document.getElementById('mini-pet-sprite');
    if (!bubble || !pet) return;

    bubble.textContent = text;
    bubble.classList.add('visible');

    // 말풍선 위치를 캐릭터 위에 맞춤
    const petTop  = parseFloat(pet.style.top  || 0);
    const petLeft = parseFloat(pet.style.left || 0);
    bubble.style.top  = (petTop  - 28) + 'px';
    bubble.style.left = (petLeft - 10) + 'px';

    clearTimeout(bubble._timer);
    bubble._timer = setTimeout(() => bubble.classList.remove('visible'), duration);
}

// ── 등반 루프 ──────────────────────────────────────────

function tickClimb() {
    if (!loopActive) return;
    const pet = document.getElementById('mini-pet-sprite');
    if (!pet) return;

    if (climbState.phase === 'table') {
        climbState.row++;
        pet.classList.add('mps-struggle');
        showSpeech(getRandom(SPEECHES.climb), 700);

        setTimeout(() => {
            if (!loopActive) return;
            placeAtTableRow(climbState.row);
            pet.classList.remove('mps-struggle');

            if (climbState.row >= TABLE_ROWS) {
                pet.classList.add('mps-celebrate');
                showSpeech(getRandom(SPEECHES.top), 1200);
                setTimeout(() => {
                    if (!loopActive) return;
                    pet.classList.remove('mps-celebrate');
                    climbState.phase = 'chart';
                    climbState.barIndex = 0;
                    climbState.barProgress = 0;
                    tickTimer = setTimeout(tickClimb, 1000);
                }, 1400);
                return;
            }
            tickTimer = setTimeout(tickClimb, 600 + Math.random() * 300);
        }, 300);

    } else if (climbState.phase === 'chart') {
        climbState.barProgress += 22 + Math.random() * 15;
        pet.classList.add('mps-struggle');
        showSpeech(getRandom(SPEECHES.climb), 600);

        setTimeout(() => {
            if (!loopActive) return;
            placeAtChartBar(climbState.barIndex, Math.min(climbState.barProgress, 98));
            pet.classList.remove('mps-struggle');

            if (climbState.barProgress >= 100) {
                if (climbState.barIndex < CHART_BARS - 1) {
                    showSpeech(getRandom(SPEECHES.top), 700);
                    climbState.barIndex++;
                    climbState.barProgress = 0;
                    tickTimer = setTimeout(tickClimb, 900);
                } else {
                    pet.classList.add('mps-celebrate');
                    showSpeech(getRandom(SPEECHES.celebrate), 1500);
                    setTimeout(() => {
                        if (!loopActive) return;
                        pet.classList.remove('mps-celebrate');
                        fallDown();
                    }, 1800);
                }
                return;
            }
            tickTimer = setTimeout(tickClimb, 500 + Math.random() * 400);
        }, 300);
    }
}

function fallDown() {
    const pet = document.getElementById('mini-pet-sprite');
    if (!pet) return;

    pet.classList.add('mps-fall');
    showSpeech(getRandom(SPEECHES.fall), 1000);

    setTimeout(() => placeAtTableRow(0), 100);

    setTimeout(() => {
        if (!loopActive) return;
        pet.classList.remove('mps-fall');
        showSpeech(getRandom(SPEECHES.idle), 1200);
        climbState = { phase: 'table', row: 0, barIndex: 0, barProgress: 0 };
        tickTimer = setTimeout(tickClimb, 2000);
    }, 1200);
}
