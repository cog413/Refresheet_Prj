#!/usr/bin/env node
/**
 * generate-seed-ranking-data.js
 *
 * Generates seed/NPC ranking data for Refresheet.
 * Outputs:  scripts/seed-ranking-data.sql
 * Apply:    npx wrangler d1 execute db_game_info --remote --file=./scripts/seed-ranking-data.sql
 * Remove:   DELETE FROM game_scores WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);
 *           DELETE FROM users WHERE is_virtual = 1;
 *
 * Safety guarantees:
 *  - All accounts: is_virtual=1, source='seed'|'npc', google_sub=NULL, onboarding_done=1
 *  - Emails use @seed.refresheet.local — non-routable, never sent
 *  - No auth_sessions, no auth_events, no OAuth rows
 *  - game_scores only — no real traffic, no ad impressions
 *  - Points calculated from scores for wallet consistency, but no real transactions needed
 *  - Hourly limit: max 3 games within any 60-min window (matches GLOBAL_HOURLY_PLAY_LIMIT)
 *  - Daily limit:  max 6 games per calendar day KST (seed data policy)
 */

'use strict';

const { randomUUID } = require('crypto');
const fs             = require('fs');
const path           = require('path');

// ─── helpers ────────────────────────────────────────────────────────────────

function makeId(prefix) {
    return `${prefix}_${randomUUID().replaceAll('-', '')}`;
}

/** Simple seeded PRNG (mulberry32) for reproducible jitter. */
function makePrng(seed) {
    let s = seed >>> 0;
    return () => {
        s |= 0; s = s + 0x6d2b79f5 | 0;
        let t = Math.imul(s ^ (s >>> 15), 1 | s);
        t = t + Math.imul(t ^ (t >>> 7), 61 | t) ^ t;
        return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
}

const prng = makePrng(0xdeadbeef);

/** Integer in [min, max] inclusive. */
function randInt(min, max) {
    return min + Math.floor(prng() * (max - min + 1));
}

/** Random element from array. */
function pick(arr) {
    return arr[Math.floor(prng() * arr.length)];
}

/** KST date string YYYY-MM-DD from a UTC Date. */
function kstDate(d) {
    const kst = new Date(d.getTime() + 9 * 3600000);
    return kst.toISOString().slice(0, 10);
}

/** ISO UTC string for a given KST hour:minute on a KST date string. */
function kstToUtcIso(kstDateStr, kstHour, kstMin) {
    // Parse as midnight UTC then adjust: KST midnight = UTC −9h
    const utc = new Date(`${kstDateStr}T00:00:00.000Z`);
    utc.setUTCHours(kstHour - 9, kstMin, randInt(0, 59), randInt(0, 999));
    return utc.toISOString();
}

/** Day-of-week in KST (0=Sun … 6=Sat). */
function kstDow(kstDateStr) {
    return new Date(`${kstDateStr}T09:00:00.000Z`).getUTCDay();
}

/** Pad a string for SQL safety (no string interpolation in values). */
function sq(v) {
    if (v === null || v === undefined) return 'NULL';
    return `'${String(v).replaceAll("'", "''")}'`;
}

// ─── account definitions ─────────────────────────────────────────────────────

const SEED_USERS = [
    // ── seed accounts ───────────────────────────────────────────────────────
    {
        user_id:       'seed_usr_kim_daeri',
        email:         'seed_kim_daeri@seed.refresheet.local',
        employee_name: '김대리',
        company:       'Refresheet Office',
        source:        'seed',
        commute_start: '09:00',
        commute_end:   '18:00',
        // Behaviour profile (used by schedule builder)
        profile: {
            label:        '점심시간형',
            playHoursKST: [12, 13],     // preferred KST hours
            preferredGames: ['2048', '2048', 'sudoku'],
            skillLevel:   'mid_high',   // low | mid | mid_high | high
            activeDays:   'weekday',    // all | weekday | weekend | random
            playFreq:     0.65,         // probability of playing on an eligible day
            maxPerDay:    4,
        },
    },
    {
        user_id:       'seed_usr_park_staff',
        email:         'seed_park_staff@seed.refresheet.local',
        employee_name: '박사원',
        company:       'Refresheet Office',
        source:        'seed',
        commute_start: '09:00',
        commute_end:   '18:00',
        profile: {
            label:        '오후형',
            playHoursKST: [14, 15, 16],
            preferredGames: ['sudoku', 'sudoku', '2048'],
            skillLevel:   'mid',
            activeDays:   'weekday',
            playFreq:     0.55,
            maxPerDay:    3,
        },
    },
    {
        user_id:       'seed_usr_lee_manager',
        email:         'seed_lee_manager@seed.refresheet.local',
        employee_name: '이과장',
        company:       'Refresheet Office',
        source:        'seed',
        commute_start: '08:30',
        commute_end:   '18:00',
        profile: {
            label:        '아침형',
            playHoursKST: [9, 10],
            preferredGames: ['typing_game', 'typing_game', '2048'],
            skillLevel:   'mid_high',
            activeDays:   'weekday',
            playFreq:     0.60,
            maxPerDay:    4,
        },
    },
    {
        user_id:       'seed_usr_choi_junior',
        email:         'seed_choi_junior@seed.refresheet.local',
        employee_name: '최주임',
        company:       'Refresheet Office',
        source:        'seed',
        commute_start: '09:00',
        commute_end:   '18:30',
        profile: {
            label:        '퇴근형',
            playHoursKST: [17, 18],
            preferredGames: ['2048', '2048', 'sudoku'],
            skillLevel:   'low_mid',
            activeDays:   'all',
            playFreq:     0.45,
            maxPerDay:    3,
        },
    },
    {
        user_id:       'seed_usr_jung_intern',
        email:         'seed_jung_intern@seed.refresheet.local',
        employee_name: '정인턴',
        company:       'Refresheet Office',
        source:        'seed',
        commute_start: '09:00',
        commute_end:   '18:00',
        profile: {
            label:        '야간 플레이형',
            playHoursKST: [22, 23, 0],
            preferredGames: ['sudoku', 'typing_game'],
            skillLevel:   'low',
            activeDays:   'all',
            playFreq:     0.40,
            maxPerDay:    2,
        },
    },
    {
        user_id:       'seed_usr_yoon_mgr',
        email:         'seed_yoon_mgr@seed.refresheet.local',
        employee_name: '윤매니저',
        company:       'Refresheet Office',
        source:        'seed',
        commute_start: '08:00',
        commute_end:   '18:00',
        profile: {
            label:        'SDK 선호',
            playHoursKST: [10, 11],
            preferredGames: ['sudoku', 'sudoku', 'sudoku', '2048'],
            skillLevel:   'high',
            activeDays:   'weekday',
            playFreq:     0.70,
            maxPerDay:    5,
        },
    },
    {
        user_id:       'seed_usr_oh_lead',
        email:         'seed_oh_lead@seed.refresheet.local',
        employee_name: '오팀장',
        company:       'Refresheet Office',
        source:        'seed',
        commute_start: '08:00',
        commute_end:   '17:30',
        profile: {
            label:        'Reference 위주',
            playHoursKST: [13, 14],
            preferredGames: ['typing_game', 'typing_game', 'typing_game', 'sudoku'],
            skillLevel:   'high',
            activeDays:   'weekday',
            playFreq:     0.70,
            maxPerDay:    5,
        },
    },
    // ── NPC accounts ────────────────────────────────────────────────────────
    {
        user_id:       'npc_usr_qa_bot',
        email:         'npc_qa_bot@seed.refresheet.local',
        employee_name: 'QA_BOT',
        company:       'Refresheet Lab',
        source:        'npc',
        commute_start: '00:00',
        commute_end:   '23:59',
        profile: {
            label:        'QA_BOT',
            playHoursKST: [10, 11, 14, 15, 16],
            preferredGames: ['typing_game', 'typing_game', 'typing_game', '2048'],
            skillLevel:   'mid',
            activeDays:   'npc_qa',    // custom: 2-3 times per week
            playFreq:     1.0,
            maxPerDay:    6,
        },
    },
    {
        user_id:       'npc_usr_kim_daeri',
        email:         'npc_kim_daeri@seed.refresheet.local',
        employee_name: '김대리NPC',
        company:       'Refresheet Lab',
        source:        'npc',
        commute_start: '09:00',
        commute_end:   '18:00',
        profile: {
            label:        '김대리NPC',
            playHoursKST: [11],         // fixed: 11:xx KST
            preferredGames: ['2048', '2048', 'sudoku'],
            skillLevel:   'mid_high',
            activeDays:   'npc_kim',   // custom: every 3rd day of month
            playFreq:     1.0,
            maxPerDay:    3,           // exactly 3: 2048×2 + sudoku×1
        },
    },
    {
        user_id:       'npc_usr_todaki',
        email:         'npc_todaki@seed.refresheet.local',
        employee_name: '토닥이NPC',
        company:       'Refresheet Lab',
        source:        'npc',
        commute_start: '09:00',
        commute_end:   '18:00',
        profile: {
            label:        '토닥이NPC',
            playHoursKST: [12, 13],
            preferredGames: ['sudoku', '2048'],
            skillLevel:   'mid',
            activeDays:   'npc_todaki', // custom: weekday random
            playFreq:     0.60,
            maxPerDay:    2,
        },
    },
];

// ─── score generators ────────────────────────────────────────────────────────

const SCORE_RANGES = {
    '2048': {
        low:      [300,  2500],
        low_mid:  [800,  4000],
        mid:      [1500, 6000],
        mid_high: [2000, 10000],
        high:     [3500, 14000],
    },
    sudoku: {
        low:      [200,  1200],
        low_mid:  [600,  2200],
        mid:      [1000, 3500],
        mid_high: [1800, 5000],
        high:     [2800, 6500],
    },
    typing_game: {
        low:      [300,  1500],
        low_mid:  [700,  2500],
        mid:      [1500, 4500],
        mid_high: [2000, 5500],
        high:     [3000, 7000],
    },
};

// NPC score ranges derived from cron Worker skill=0.60 cap:
// effectiveMax = base.min + (base.max - base.min) * 0.60
// 2048: 600 + (8000-600)*0.60 = 5040  | sudoku: 400 + (5500-400)*0.60 = 3460
// typing_game: 400 + (6000-400)*0.60 = 3760
const NPC_RANGES = {
    '2048':       [600,  5040],
    sudoku:       [400,  3460],
    typing_game:  [400,  3760],
};

function rollScore(userId, gameType) {
    if (['npc_usr_kim_daeri', 'npc_usr_qa_bot', 'npc_usr_todaki'].includes(userId)) {
        const r = NPC_RANGES[gameType] ?? [400, 3000];
        return randInt(r[0], r[1]);
    }
    const user = SEED_USERS.find(u => u.user_id === userId);
    const level = user?.profile?.skillLevel ?? 'mid';
    const range = SCORE_RANGES[gameType]?.[level] ?? [500, 3000];
    // Add natural variance: occasionally underperform or overperform
    const base = randInt(range[0], range[1]);
    const variance = prng() < 0.10 ? randInt(-Math.floor(range[0] * 0.4), 0) : 0;
    return Math.max(100, base + variance);
}

function rollDuration(gameType, score) {
    // Approximate realistic durations per game type
    if (gameType === 'sudoku')      return randInt(45, 300);
    if (gameType === '2048')        return randInt(30, 180);
    if (gameType === 'typing_game') return randInt(40, 120);
    return randInt(30, 180);
}

// ─── schedule builder ────────────────────────────────────────────────────────

const DAYS_BACK = 28;

/**
 * Returns an array of { kstDateStr, playsThisDay } objects for a given user
 * covering the past DAYS_BACK days.
 */
function buildSchedule(user) {
    const today  = new Date();
    const kstNow = new Date(today.getTime() + 9 * 3600000);
    const dates  = [];

    for (let i = DAYS_BACK; i >= 1; i--) {
        const d    = new Date(kstNow);
        d.setUTCDate(kstNow.getUTCDate() - i);
        const ds   = kstDate(d);
        const dow  = kstDow(ds);           // 0=Sun 6=Sat
        const dayN = parseInt(ds.slice(8)); // day of month (1–31)

        const { activeDays, playFreq, maxPerDay, preferredGames, playHoursKST } = user.profile;

        let eligible = false;

        if (activeDays === 'all') {
            eligible = prng() < playFreq;
        } else if (activeDays === 'weekday') {
            eligible = (dow >= 1 && dow <= 5) && prng() < playFreq;
        } else if (activeDays === 'weekend') {
            eligible = (dow === 0 || dow === 6) && prng() < playFreq;
        } else if (activeDays === 'npc_kim') {
            // Every 3rd day of month
            eligible = (dayN % 3 === 0);
        } else if (activeDays === 'npc_qa') {
            // 2–3 times per week: Mon / Wed / Fri or random subset
            eligible = [1, 3, 5].includes(dow) && prng() < 0.80;
        } else if (activeDays === 'npc_todaki') {
            // Weekday, random
            eligible = (dow >= 1 && dow <= 5) && prng() < 0.55;
        }

        if (!eligible) continue;

        // Determine number of games this day (1 … maxPerDay, capped at 6)
        const cap = Math.min(maxPerDay, 6);
        let nGames;

        if (activeDays === 'npc_kim') {
            nGames = 3; // always exactly 2048×2 + sudoku×1
        } else {
            nGames = randInt(1, cap);
        }

        dates.push({ kstDateStr: ds, nGames });
    }
    return dates;
}

/**
 * For a single day's plays, generate { played_at ISO, gameType } objects.
 * Enforces: max 3 games in any rolling 60-min window.
 */
function buildDayPlays(user, kstDateStr, nGames) {
    const { playHoursKST, preferredGames } = user.profile;
    const plays = [];

    // Spread games across available hours with natural jitter.
    // Simple approach: pick a base hour, space games at least 3–15 min apart.
    let baseHour = pick(playHoursKST);
    let minuteOffset = randInt(0, 45);

    for (let g = 0; g < nGames; g++) {
        // After every 3 games, ensure we've crossed into a new hour.
        if (g > 0 && g % 3 === 0) {
            baseHour = (baseHour + 1) % 24;
            minuteOffset = randInt(0, 20);
        }

        let gameType;
        if (user.user_id === 'npc_usr_kim_daeri') {
            // Exact spec: 2048, 2048, sudoku
            gameType = ['2048', '2048', 'sudoku'][g] ?? pick(preferredGames);
        } else {
            gameType = pick(preferredGames);
        }

        const kstHour = baseHour;
        const kstMin  = Math.min(59, minuteOffset + g * randInt(3, 12));
        const playedAt = kstToUtcIso(kstDateStr, kstHour, kstMin % 60);

        plays.push({ played_at: playedAt, gameType });
    }

    return plays;
}

// ─── SQL generation ───────────────────────────────────────────────────────────

function generateSQL() {
    const lines = [];

    lines.push('-- ============================================================');
    lines.push('-- Refresheet seed ranking data');
    lines.push(`-- Generated: ${new Date().toISOString()}`);
    lines.push('-- Covers:    past 28 days from generation date');
    lines.push('--');
    lines.push('-- Prerequisites:');
    lines.push('--   Migration 013 must be applied first:');
    lines.push('--   npx wrangler d1 execute db_game_info --remote --file=./docs/migrations/013_virtual_account_flags.sql');
    lines.push('--');
    lines.push('-- Apply this file:');
    lines.push('--   npx wrangler d1 execute db_game_info --remote --file=./scripts/seed-ranking-data.sql');
    lines.push('--');
    lines.push('-- Remove all seed data:');
    lines.push('--   npx wrangler d1 execute db_game_info --remote \\');
    lines.push("--     --command=\"DELETE FROM game_scores WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual=1);\"");
    lines.push("--     --command=\"DELETE FROM users WHERE is_virtual=1;\"");
    lines.push('--');
    lines.push('-- Filter out in stats:');
    lines.push("--   ... JOIN users u ON u.user_id = gs.user_id WHERE u.is_virtual = 0 ...");
    lines.push('-- ============================================================');
    lines.push('');

    // ── 1. Clean previous seed data (idempotent re-run) ───────────────────
    lines.push('-- Step 1: Remove previous seed data (safe re-run)');
    lines.push("DELETE FROM game_scores WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);");
    lines.push("DELETE FROM user_points   WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);");
    lines.push("DELETE FROM point_wallets WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);");
    lines.push("DELETE FROM avatars       WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);");
    lines.push("DELETE FROM users         WHERE is_virtual = 1;");
    lines.push('');

    // ── 2. Users ──────────────────────────────────────────────────────────
    lines.push('-- Step 2: Seed / NPC user accounts');
    lines.push('-- All accounts: is_virtual=1, google_sub=NULL, onboarding_done=1');
    lines.push('-- Emails: @seed.refresheet.local — non-routable, never sent');

    const now = new Date().toISOString();

    for (const u of SEED_USERS) {
        lines.push(`INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)`);
        lines.push(`VALUES (${[
            sq(u.user_id),
            sq(u.email),
            'NULL',                       // google_sub: never linked
            sq(now),
            sq(now),
            sq(u.company),
            sq(u.commute_start),
            sq(u.commute_end),
            1,                            // onboarding_done — required for ranking
            sq(u.employee_name),
            1,                            // is_active
            sq(u.source),
            1,                            // is_virtual
        ].join(', ')});`);
    }
    lines.push('');

    // ── 3. Avatars (minimal — character_key default) ──────────────────────
    lines.push('-- Step 3: Avatar rows (minimal, required for /api/me parity)');
    for (const u of SEED_USERS) {
        const charKey = u.source === 'npc' ? 'mong' : pick(['mong', 'rabbit', 'mong', 'mong']);
        lines.push(`INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)`);
        lines.push(`VALUES (${[
            sq(u.user_id),
            sq(u.employee_name),
            sq('type_a'),
            sq(charKey),
            sq(now),
            sq(now),
        ].join(', ')});`);
    }
    lines.push('');

    // ── 4. Game scores ────────────────────────────────────────────────────
    lines.push('-- Step 4: Game score history (past 28 days, max 3/hour, max 6/day)');
    lines.push('-- All score IDs prefixed seed_gsc_ / npc_gsc_ for easy identification');

    let totalScores = 0;
    const scoreInserts = [];

    for (const u of SEED_USERS) {
        const schedule = buildSchedule(u);

        for (const { kstDateStr, nGames } of schedule) {
            const dayPlays = buildDayPlays(u, kstDateStr, nGames);

            for (const { played_at, gameType } of dayPlays) {
                const prefix   = u.source === 'npc' ? 'npc_gsc' : 'seed_gsc';
                const scoreId  = makeId(prefix);
                const score    = rollScore(u.user_id, gameType);
                const duration = rollDuration(gameType, score);

                scoreInserts.push(`INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)`);
                scoreInserts.push(`VALUES (${[
                    sq(scoreId),
                    sq(u.user_id),
                    sq(gameType),
                    score,
                    sq(played_at),
                    duration,
                    sq(JSON.stringify({ seed: true, source: u.source })),
                ].join(', ')});`);
                totalScores++;
            }
        }
    }

    lines.push(...scoreInserts);
    lines.push('');

    // ── 5. Point wallets (approximate, from score sum) ────────────────────
    lines.push('-- Step 5: Point wallets (approximated from total scores / 10)');
    lines.push('-- Does not create real point_transactions — admin adjust only');
    for (const u of SEED_USERS) {
        // Estimate: average score 3000, 3 games/week, 4 weeks → ~3600 pts
        const approxBalance = randInt(800, 5000);
        lines.push(`INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)`);
        lines.push(`VALUES (${[sq(u.user_id), approxBalance, sq(now)].join(', ')});`);

        lines.push(`INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)`);
        lines.push(`VALUES (${[sq(u.user_id), approxBalance, approxBalance, 0, sq(now), sq(now)].join(', ')});`);
    }
    lines.push('');

    // ── 6. Company tags ───────────────────────────────────────────────────
    lines.push('-- Step 6: Company tags for seed companies');
    const seedTagId = makeId('ctag');
    const labTagId  = makeId('ctag');
    lines.push(`INSERT OR IGNORE INTO companies (id, name, created_at)`);
    lines.push(`VALUES (${sq(seedTagId)}, ${sq('Refresheet Office')}, ${sq(now)});`);
    lines.push(`INSERT OR IGNORE INTO companies (id, name, created_at)`);
    lines.push(`VALUES (${sq(labTagId)},  ${sq('Refresheet Lab')},    ${sq(now)});`);
    lines.push('');

    // ── Summary comment ───────────────────────────────────────────────────
    lines.push(`-- Summary: ${SEED_USERS.length} virtual users, ~${totalScores} game_score rows`);
    lines.push(`-- Seed accounts (source=seed): ${SEED_USERS.filter(u => u.source === 'seed').length}`);
    lines.push(`-- NPC accounts  (source=npc):  ${SEED_USERS.filter(u => u.source === 'npc').length}`);
    lines.push('-- To verify isolation:');
    lines.push("--   SELECT source, is_virtual, COUNT(*) FROM users GROUP BY source, is_virtual;");
    lines.push("--   SELECT u.source, COUNT(gs.id) AS plays FROM game_scores gs JOIN users u USING(user_id) GROUP BY u.source;");

    return lines.join('\n');
}

// ─── write output ────────────────────────────────────────────────────────────

const outPath = path.join(__dirname, 'seed-ranking-data.sql');
const sql     = generateSQL();

fs.writeFileSync(outPath, sql, 'utf8');

// Count lines for confirmation
const scoreLines = (sql.match(/INSERT OR IGNORE INTO game_scores/g) || []).length;
const userLines  = (sql.match(/INSERT OR IGNORE INTO users/g) || []).length;
console.log(`✓ Generated: ${path.relative(process.cwd(), outPath)}`);
console.log(`  Users:       ${userLines}`);
console.log(`  GameScores:  ${scoreLines}`);
console.log('');
console.log('Next steps:');
console.log('  1. Apply migration 013 (if not yet done):');
console.log('     npx wrangler d1 migrations apply DB --remote');
console.log('  2. Apply seed data:');
console.log('     npx wrangler d1 execute db_game_info --remote --file=./scripts/seed-ranking-data.sql');
console.log('  3. Verify:');
console.log("     npx wrangler d1 execute db_game_info --remote --command=\"SELECT source, is_virtual, COUNT(*) as cnt FROM users GROUP BY source, is_virtual;\"");
