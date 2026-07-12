/**
 * src/worker/cron.js — Refresheet seed activity cron Worker
 *
 * Deploy:   npx wrangler deploy --config wrangler.cron.toml
 * Schedule: daily 02:00 UTC (11:00 KST)  →  wrangler.cron.toml [triggers]
 *
 * Timeline (repeats forever in rolling 14-day cycles — never goes idle):
 *   Days  0–6  of cycle  (week 1)  full activity per profile
 *   Days  7–13 of cycle  (week 2)  50% activity, 80% score ceiling
 *   Cycle boundary       decay virtual-user point balances, then cycle repeats
 *
 * Safety guarantees:
 *   - Only touches rows WHERE users.is_virtual = 1
 *   - No OAuth / auth_sessions / ad impressions
 *   - Max 3 plays per rolling hour  (GLOBAL_HOURLY_PLAY_LIMIT parity)
 *   - Max 6 plays per calendar day KST per user
 *   - NPC accounts (source='npc'): skill cap 0.60 → lower avg score than seed accounts
 */

'use strict';

// ─── constants ───────────────────────────────────────────────────────────────

const SEED_WINDOW_DAYS      = 14;   // length of one repeating activity/decay cycle
const CYCLE_DECAY_FACTOR    = 0.5;  // point-balance decay applied at each cycle boundary
const WEEK2_ACTIVITY_FACTOR = 0.5;
const WEEK2_SCORE_FACTOR    = 0.8;  // week-2 score ceiling multiplier
const HOURLY_PLAY_LIMIT     = 3;    // matches GLOBAL_HOURLY_PLAY_LIMIT
const DAILY_HARD_CAP        = 6;

// ─── profiles ────────────────────────────────────────────────────────────────
//
// skill:  upper-bound factor applied to score range.
//         NPC accounts capped at 0.60 so their avg score stays below seed accounts
//         while still allowing "엎치락뒤치락" overlap at the tails.
//
// days:   'weekday' | 'all' | 'npc_qa' | 'npc_kim' | 'npc_todaki'
// prob:   base probability of playing on an eligible day
// cap:    max plays on an active day (hard-capped to DAILY_HARD_CAP)
// games:  weighted pick list
// hours:  preferred KST play hours (used for played_at timestamp)

const SEED_PROFILES = [
    // ── 7 seed accounts ─────────────────────────────────────────────────────
    {
        userId: 'seed_usr_kim_daeri',
        isNpc:  false, skill: 0.85,
        days:  'weekday', prob: 0.65, cap: 4,
        games: ['2048', '2048', 'sudoku'],
        hours: [12, 13],
    },
    {
        userId: 'seed_usr_park_staff',
        isNpc:  false, skill: 0.70,
        days:  'weekday', prob: 0.55, cap: 3,
        games: ['sudoku', 'sudoku', '2048'],
        hours: [14, 15],
    },
    {
        userId: 'seed_usr_lee_manager',
        isNpc:  false, skill: 0.85,
        days:  'weekday', prob: 0.60, cap: 4,
        games: ['typing_game', 'typing_game', '2048'],
        hours: [9, 10],
    },
    {
        userId: 'seed_usr_choi_junior',
        isNpc:  false, skill: 0.55,
        days:  'all', prob: 0.45, cap: 3,
        games: ['2048', '2048', 'sudoku'],
        hours: [17, 18],
    },
    {
        userId: 'seed_usr_jung_intern',
        isNpc:  false, skill: 0.40,
        days:  'all', prob: 0.40, cap: 2,
        games: ['sudoku', 'typing_game'],
        hours: [22, 23, 0],
    },
    {
        userId: 'seed_usr_yoon_mgr',
        isNpc:  false, skill: 1.00,
        days:  'weekday', prob: 0.70, cap: 5,
        games: ['sudoku', 'sudoku', 'sudoku', '2048'],
        hours: [10, 11],
    },
    {
        userId: 'seed_usr_oh_lead',
        isNpc:  false, skill: 1.00,
        days:  'weekday', prob: 0.70, cap: 5,
        games: ['typing_game', 'typing_game', 'typing_game', 'sudoku'],
        hours: [13, 14],
    },
    // ── 3 NPC accounts — skill capped at 0.60 (lower avg than seed) ──────
    {
        userId: 'npc_usr_qa_bot',
        isNpc:  true, skill: 0.60,
        days:  'npc_qa', prob: 0.80, cap: 4,
        games: ['typing_game', 'typing_game', 'typing_game', '2048'],
        hours: [10, 11, 14],
    },
    {
        userId: 'npc_usr_kim_daeri',
        isNpc:  true, skill: 0.60,
        days:  'npc_kim', prob: 1.00, cap: 3,
        games: ['2048', '2048', 'sudoku'],
        hours: [11],
    },
    {
        userId: 'npc_usr_todaki',
        isNpc:  true, skill: 0.60,
        days:  'npc_todaki', prob: 0.60, cap: 2,
        games: ['sudoku', '2048'],
        hours: [12, 13],
    },

    // ── 14 additional seed accounts (3x roster expansion) ─────────────────
    {
        userId: 'seed_usr_song_lg',
        isNpc:  false, skill: 0.40,
        days:  'all', prob: 0.40, cap: 2,
        games: ['sudoku', 'typing_game'],
        hours: [19, 20, 21],
    },
    {
        userId: 'seed_usr_han_sk',
        isNpc:  false, skill: 0.55,
        days:  'weekday', prob: 0.50, cap: 3,
        games: ['2048', 'sudoku'],
        hours: [11, 12],
    },
    {
        userId: 'seed_usr_baek_coupang',
        isNpc:  false, skill: 0.70,
        days:  'all', prob: 0.55, cap: 3,
        games: ['sudoku', '2048'],
        hours: [9, 10],
    },
    {
        userId: 'seed_usr_woo_baemin',
        isNpc:  false, skill: 0.85,
        days:  'weekday', prob: 0.60, cap: 4,
        games: ['typing_game', '2048'],
        hours: [18, 19],
    },
    {
        userId: 'seed_usr_shin_toss',
        isNpc:  false, skill: 1.00,
        days:  'weekday', prob: 0.70, cap: 5,
        games: ['sudoku', 'sudoku', 'sudoku'],
        hours: [9, 10, 11],
    },
    {
        userId: 'seed_usr_ahn_carrot',
        isNpc:  false, skill: 0.40,
        days:  'all', prob: 0.35, cap: 2,
        games: ['2048'],
        hours: [15, 16],
    },
    {
        userId: 'seed_usr_jang_krafton',
        isNpc:  false, skill: 0.70,
        days:  'weekday', prob: 0.55, cap: 3,
        games: ['2048', '2048', 'typing_game'],
        hours: [13, 14],
    },
    {
        userId: 'seed_usr_ryu_nexon',
        isNpc:  false, skill: 0.55,
        days:  'all', prob: 0.45, cap: 3,
        games: ['2048', '2048', '2048'],
        hours: [20, 21, 22],
    },
    {
        userId: 'seed_usr_moon_ncsoft',
        isNpc:  false, skill: 0.85,
        days:  'weekday', prob: 0.60, cap: 4,
        games: ['sudoku', 'typing_game'],
        hours: [16, 17],
    },
    {
        userId: 'seed_usr_ko_cjenm',
        isNpc:  false, skill: 0.40,
        days:  'weekday', prob: 0.40, cap: 2,
        games: ['typing_game'],
        hours: [8, 9],
    },
    {
        userId: 'seed_usr_yang_lotte',
        isNpc:  false, skill: 0.70,
        days:  'weekday', prob: 0.50, cap: 3,
        games: ['sudoku', '2048'],
        hours: [12, 13],
    },
    {
        userId: 'seed_usr_bae_gs',
        isNpc:  false, skill: 0.55,
        days:  'all', prob: 0.45, cap: 3,
        games: ['2048', 'sudoku'],
        hours: [7, 8, 22, 23],
    },
    {
        userId: 'seed_usr_hong_shinhan',
        isNpc:  false, skill: 1.00,
        days:  'weekday', prob: 0.65, cap: 4,
        games: ['sudoku', 'sudoku', 'sudoku', 'sudoku'],
        hours: [10, 11],
    },
    {
        userId: 'seed_usr_nam_posco',
        isNpc:  false, skill: 0.85,
        days:  'weekday', prob: 0.55, cap: 3,
        games: ['typing_game', '2048'],
        hours: [14, 15],
    },

    // ── 6 additional NPC accounts — skill capped at 0.60 ───────────────────
    {
        userId: 'npc_usr_hr_bot',
        isNpc:  true, skill: 0.60,
        days:  'npc_qa', prob: 0.80, cap: 4,
        games: ['typing_game', 'typing_game', '2048'],
        hours: [9, 13, 17],
    },
    {
        userId: 'npc_usr_sales_bot',
        isNpc:  true, skill: 0.60,
        days:  'npc_kim', prob: 1.00, cap: 3,
        games: ['sudoku', '2048'],
        hours: [15],
    },
    {
        userId: 'npc_usr_night_owl',
        isNpc:  true, skill: 0.60,
        days:  'npc_todaki', prob: 0.60, cap: 2,
        games: ['sudoku', 'typing_game'],
        hours: [23, 0, 1],
    },
    {
        userId: 'npc_usr_intern_bot',
        isNpc:  true, skill: 0.60,
        days:  'npc_qa', prob: 0.80, cap: 4,
        games: ['2048', '2048', 'sudoku'],
        hours: [10, 16],
    },
    {
        userId: 'npc_usr_cs_bot',
        isNpc:  true, skill: 0.60,
        days:  'npc_kim', prob: 1.00, cap: 3,
        games: ['typing_game', '2048'],
        hours: [11, 14],
    },
    {
        userId: 'npc_usr_weekend_bot',
        isNpc:  true, skill: 0.60,
        days:  'npc_todaki', prob: 0.60, cap: 2,
        games: ['2048', 'sudoku'],
        hours: [13, 15],
    },
];

// Base score ranges (full skill = 1.0).
// Effective max = min + (max - min) * skillFactor × weekFactor
// NPC (skill=0.60): e.g. 2048 effectiveMax ≈ 1200 + 14800×0.60 = 10080 → avg ≈ 5640
// Seed high (1.00): e.g. 2048 effectiveMax = 16000                    → avg ≈ 8600
const SCORE_BASE = {
    '2048':        { min: 1200, max: 16000 },
    'sudoku':      { min: 100,  max: 1375  },
    'typing_game': { min: 800,  max: 12000 },
};

// ─── helpers ──────────────────────────────────────────────────────────────────

function makeId(prefix) {
    return `${prefix}_${crypto.randomUUID().replaceAll('-', '')}`;
}

function kstNow() {
    return new Date(Date.now() + 9 * 3_600_000);
}

function kstDateStr(d) {
    return new Date(d.getTime() + 9 * 3_600_000).toISOString().slice(0, 10);
}

function kstDow(dateStr) {
    return new Date(`${dateStr}T09:00:00.000Z`).getUTCDay(); // 0=Sun
}

function dayOfMonth(dateStr) {
    return parseInt(dateStr.slice(8), 10);
}

function diffDays(fromDateStr, toDateStr) {
    return Math.floor((Date.parse(toDateStr) - Date.parse(fromDateStr)) / 86_400_000);
}

function rollScore(gameType, skillFactor, weekFactor) {
    const base = SCORE_BASE[gameType] ?? { min: 400, max: 4000 };
    const effectiveMax = Math.floor(
        base.min + (base.max - base.min) * skillFactor * weekFactor
    );
    const hi = Math.max(base.min + 100, effectiveMax);
    return base.min + Math.floor(Math.random() * (hi - base.min + 1));
}

function rollDuration(gameType) {
    if (gameType === 'sudoku')       return 45  + Math.floor(Math.random() * 255);
    if (gameType === '2048')         return 30  + Math.floor(Math.random() * 150);
    if (gameType === 'typing_game')  return 40  + Math.floor(Math.random() * 80);
    return 60;
}

/**
 * Build a played_at ISO string for today KST at a preferred hour.
 * If the chosen time is in the future, shift it one day back (safe guard).
 */
function buildPlayedAt(preferredHours) {
    const todayKst = kstDateStr(new Date());
    const hour = preferredHours[Math.floor(Math.random() * preferredHours.length)];
    const min  = Math.floor(Math.random() * 60);
    const sec  = Math.floor(Math.random() * 60);
    const ts   = new Date(`${todayKst}T${String(hour).padStart(2, '0')}:${String(min).padStart(2, '0')}:${String(sec).padStart(2, '0')}+09:00`);
    if (ts > new Date()) ts.setUTCDate(ts.getUTCDate() - 1);
    return ts.toISOString();
}

function isEligibleToday(profile, todayDateStr, activityFactor) {
    const dow  = kstDow(todayDateStr);
    const dayN = dayOfMonth(todayDateStr);
    let baseProbability;

    switch (profile.days) {
        case 'weekday':
            baseProbability = (dow >= 1 && dow <= 5) ? profile.prob : 0;
            break;
        case 'all':
            baseProbability = profile.prob;
            break;
        case 'npc_kim':
            // every 3rd day of month
            baseProbability = (dayN % 3 === 0) ? 1.0 : 0;
            break;
        case 'npc_qa':
            // Mon / Wed / Fri
            baseProbability = [1, 3, 5].includes(dow) ? profile.prob : 0;
            break;
        case 'npc_todaki':
            baseProbability = (dow >= 1 && dow <= 5) ? profile.prob : 0;
            break;
        default:
            baseProbability = profile.prob;
    }

    return Math.random() < (baseProbability * activityFactor);
}

// ─── main cron logic ──────────────────────────────────────────────────────────

async function runSeedCron(env) {
    const db      = env.DB;
    const nowIso  = new Date().toISOString();
    const todayKst = kstDateStr(new Date());

    // seed_config must exist (created by migration 013).
    // Belt-and-suspenders CREATE IF NOT EXISTS in case migration hasn't run yet.
    await db.prepare(`
        CREATE TABLE IF NOT EXISTS seed_config (
            key        TEXT PRIMARY KEY,
            value      TEXT NOT NULL,
            updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
    `).run();

    // ── Determine days since seeding started ──────────────────────────────────
    let startRow = await db.prepare(
        `SELECT value FROM seed_config WHERE key = 'seed.start_date'`
    ).first();

    if (!startRow) {
        await db.prepare(
            `INSERT INTO seed_config (key, value, updated_at) VALUES ('seed.start_date', ?, ?)`
        ).bind(todayKst, nowIso).run();
        startRow = { value: todayKst };
    }

    const daysSinceStart = diffDays(startRow.value, todayKst);

    // ── Rolling 14-day cycle: never goes idle, just repeats forever ───────────
    // cycleIndex counts completed cycles; dayInCycle (0–13) drives week1/week2.
    const cycleIndex = Math.floor(daysSinceStart / SEED_WINDOW_DAYS);
    const dayInCycle  = daysSinceStart % SEED_WINDOW_DAYS;

    // At each new cycle boundary, decay virtual-user point balances once so
    // accumulated activity doesn't let them dominate rankings indefinitely.
    // total_earned_points stays intact (audit trail); only current_points decays.
    if (cycleIndex > 0) {
        const lastDecayRow = await db.prepare(
            `SELECT value FROM seed_config WHERE key = 'seed.last_decay_cycle'`
        ).first();
        const lastDecayCycle = lastDecayRow ? parseInt(lastDecayRow.value, 10) : -1;

        if (cycleIndex > lastDecayCycle) {
            await db.batch([
                db.prepare(`
                    UPDATE user_points
                       SET current_points = MAX(0, CAST(current_points * ? AS INTEGER)),
                           updated_at     = ?
                     WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1)
                `).bind(CYCLE_DECAY_FACTOR, nowIso),
                db.prepare(`
                    INSERT INTO seed_config (key, value, updated_at)
                    VALUES ('seed.last_decay_cycle', ?, ?)
                    ON CONFLICT(key) DO UPDATE SET value = excluded.value, updated_at = excluded.updated_at
                `).bind(String(cycleIndex), nowIso),
            ]);
        }
    }

    // ── Week 1 / 2 factors (repeats every cycle) ───────────────────────────────
    const isWeek2       = dayInCycle >= 7;
    const activityFactor = isWeek2 ? WEEK2_ACTIVITY_FACTOR : 1.0;
    const weekFactor     = isWeek2 ? WEEK2_SCORE_FACTOR    : 1.0;

    const generated = [];

    for (const profile of SEED_PROFILES) {
        if (!isEligibleToday(profile, todayKst, activityFactor)) continue;

        // Daily count check for this user (KST calendar day)
        const todayStart = new Date(`${todayKst}T00:00:00+09:00`).toISOString();
        const dailyRow   = await db.prepare(
            `SELECT COUNT(*) AS cnt FROM game_scores WHERE user_id = ? AND played_at >= ?`
        ).bind(profile.userId, todayStart).first();

        const alreadyToday = dailyRow?.cnt ?? 0;
        const dailyCap     = Math.min(profile.cap, DAILY_HARD_CAP);
        const remaining    = dailyCap - alreadyToday;
        if (remaining <= 0) continue;

        // Hourly check (current UTC hour)
        const { hourStart, hourEnd } = currentHourBounds();
        const hourlyRow = await db.prepare(
            `SELECT COUNT(*) AS cnt FROM game_scores WHERE user_id = ? AND played_at >= ? AND played_at < ?`
        ).bind(profile.userId, hourStart, hourEnd).first();

        const alreadyThisHour = hourlyRow?.cnt ?? 0;
        if (alreadyThisHour >= HOURLY_PLAY_LIMIT) continue;

        const nGames = Math.min(
            1 + Math.floor(Math.random() * remaining),
            HOURLY_PLAY_LIMIT - alreadyThisHour,
            remaining
        );

        const plays = [];
        for (let i = 0; i < nGames; i++) {
            let gameType;
            if (profile.userId === 'npc_usr_kim_daeri') {
                gameType = (['2048', '2048', 'sudoku'])[i] ?? profile.games[0];
            } else {
                gameType = profile.games[Math.floor(Math.random() * profile.games.length)];
            }

            const scoreId  = makeId(profile.isNpc ? 'npc_gsc' : 'seed_gsc');
            const score    = rollScore(gameType, profile.skill, weekFactor);
            const duration = rollDuration(gameType);
            const playedAt = buildPlayedAt(profile.hours);

            await db.prepare(`
                INSERT OR IGNORE INTO game_scores
                    (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            `).bind(
                scoreId,
                profile.userId,
                gameType,
                score,
                playedAt,
                duration,
                JSON.stringify({ seed: true, source: profile.isNpc ? 'npc' : 'seed' })
            ).run();

            plays.push({ game: gameType, score });
        }

        if (plays.length) generated.push({ user: profile.userId, plays });
    }

    return {
        status:         'ok',
        day:            daysSinceStart,
        cycle:          cycleIndex,
        dayInCycle,
        week:           isWeek2 ? 2 : 1,
        activityFactor,
        weekFactor,
        generated:      generated.length,
        details:        generated,
    };
}

// ─── utils ────────────────────────────────────────────────────────────────────

function currentHourBounds() {
    const now = new Date();
    now.setUTCMinutes(0, 0, 0);
    const hourStart = now.toISOString();
    const next      = new Date(now);
    next.setUTCHours(next.getUTCHours() + 1);
    const hourEnd   = next.toISOString();
    return { hourStart, hourEnd };
}

// ─── export ───────────────────────────────────────────────────────────────────

export default {
    // Cloudflare cron trigger
    async scheduled(event, env, ctx) {
        ctx.waitUntil(runSeedCron(env));
    },

    // Manual trigger: POST /internal/seed-cron  with  x-seed-secret header.
    // Set SEED_CRON_SECRET in wrangler.cron.toml [vars] or Cloudflare dashboard secrets.
    async fetch(request, env) {
        const url = new URL(request.url);
        if (url.pathname === '/internal/seed-cron' && request.method === 'POST') {
            const secret = request.headers.get('x-seed-secret');
            if (!env.SEED_CRON_SECRET || secret !== env.SEED_CRON_SECRET) {
                return new Response(JSON.stringify({ error: 'unauthorized' }), {
                    status: 401,
                    headers: { 'Content-Type': 'application/json' },
                });
            }
            const result = await runSeedCron(env);
            return new Response(JSON.stringify(result, null, 2), {
                headers: { 'Content-Type': 'application/json' },
            });
        }
        return new Response('not found', { status: 404 });
    },
};
