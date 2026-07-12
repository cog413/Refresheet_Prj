-- ============================================================
-- Refresheet seed ranking data
-- Generated: 2026-07-12T14:58:19.494Z
-- Covers:    past 28 days from generation date
--
-- Prerequisites:
--   Migration 013 must be applied first:
--   npx wrangler d1 execute db_game_info --remote --file=./docs/migrations/013_virtual_account_flags.sql
--
-- Apply this file:
--   npx wrangler d1 execute db_game_info --remote --file=./scripts/seed-ranking-data.sql
--
-- Remove all seed data:
--   npx wrangler d1 execute db_game_info --remote \
--     --command="DELETE FROM game_scores WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual=1);"
--     --command="DELETE FROM users WHERE is_virtual=1;"
--
-- Filter out in stats:
--   ... JOIN users u ON u.user_id = gs.user_id WHERE u.is_virtual = 0 ...
-- ============================================================

-- Step 1: Remove previous seed data (safe re-run)
DELETE FROM game_scores WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);
DELETE FROM user_points   WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);
DELETE FROM avatars       WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);
DELETE FROM users         WHERE is_virtual = 1;

-- Step 2: Seed / NPC user accounts
-- All accounts: is_virtual=1, google_sub=NULL, onboarding_done=1
-- Emails: @seed.refresheet.local — non-routable, never sent
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_kim_daeri', 'seed_kim_daeri@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '현대자동차', '09:00', '18:00', 1, '그대이제회사라고말해요', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_park_staff', 'seed_park_staff@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '삼성전자', '09:00', '18:00', 1, '내일은루팡', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_lee_manager', 'seed_lee_manager@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '애플코리아', '08:30', '18:00', 1, '나이롱머스크', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_choi_junior', 'seed_choi_junior@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '네이버웹툰', '09:00', '18:30', 1, 'KW5219', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_jung_intern', 'seed_jung_intern@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '한화오션', '09:00', '18:00', 1, '확인하러왔어요', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_yoon_mgr', 'seed_yoon_mgr@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '라인', '08:00', '18:00', 1, '제미나이에요', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_oh_lead', 'seed_oh_lead@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '카카오', '08:00', '17:30', 1, 'HSUK0425', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_qa_bot', 'npc_qa_bot@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '00:00', '23:59', 1, 'QA_BOT', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_kim_daeri', 'npc_kim_daeri@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '09:00', '18:00', 1, '김대리NPC', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_todaki', 'npc_todaki@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '09:00', '18:00', 1, '토닥이NPC', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_song_lg', 'seed_song_lg@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'LG전자', '09:00', '19:00', 1, '오늘도야근각', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_han_sk', 'seed_han_sk@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'SK하이닉스', '08:30', '17:30', 1, '상무님이봐요', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_baek_coupang', 'seed_baek_coupang@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '쿠팡', '09:00', '18:00', 1, '로켓배송중', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_woo_baemin', 'seed_woo_baemin@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '배달의민족', '10:00', '19:00', 1, '배달비가아까워', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_shin_toss', 'seed_shin_toss@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '토스', '09:00', '18:00', 1, '토스뱅커에요', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_ahn_carrot', 'seed_ahn_carrot@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '당근마켓', '09:30', '18:30', 1, '당근이세요', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_jang_krafton', 'seed_jang_krafton@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '크래프톤', '09:00', '18:00', 1, '배그하고싶다', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_ryu_nexon', 'seed_ryu_nexon@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '넥슨', '09:00', '18:00', 1, '메이플키우기', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_moon_ncsoft', 'seed_moon_ncsoft@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '엔씨소프트', '09:00', '18:00', 1, '리니지좀그만', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_ko_cjenm', 'seed_ko_cjenm@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'CJ ENM', '08:00', '19:00', 1, '막내PD입니다', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_yang_lotte', 'seed_yang_lotte@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '롯데정보통신', '09:00', '18:00', 1, '롯데카드멤버', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_bae_gs', 'seed_bae_gs@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'GS리테일', '07:00', '23:00', 1, '편의점사장님', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_hong_shinhan', 'seed_hong_shinhan@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '신한은행', '08:30', '17:30', 1, '대출상담사', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_nam_posco', 'seed_nam_posco@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', '포스코', '08:00', '17:00', 1, '철강왕후보생', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_hr_bot', 'npc_hr_bot@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '00:00', '23:59', 1, '인사봇', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_sales_bot', 'npc_sales_bot@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '00:00', '23:59', 1, '영업봇', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_night_owl', 'npc_night_owl@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '00:00', '23:59', 1, '올빼미NPC', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_intern_bot', 'npc_intern_bot@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '00:00', '23:59', 1, '인턴봇', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_cs_bot', 'npc_cs_bot@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '00:00', '23:59', 1, 'CS봇', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_weekend_bot', 'npc_weekend_bot@seed.refresheet.local', NULL, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z', 'Refresheet Lab', '00:00', '23:59', 1, '주말알바NPC', 1, 'npc', 1);

-- Step 3: Avatar rows (minimal, required for /api/me parity)
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_kim_daeri', '그대이제회사라고말해요', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_park_staff', '내일은루팡', 'type_a', 'rabbit', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_lee_manager', '나이롱머스크', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_choi_junior', 'KW5219', 'type_a', 'rabbit', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_jung_intern', '확인하러왔어요', 'type_a', 'rabbit', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_yoon_mgr', '제미나이에요', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_oh_lead', 'HSUK0425', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_qa_bot', 'QA_BOT', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_kim_daeri', '김대리NPC', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_todaki', '토닥이NPC', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_song_lg', '오늘도야근각', 'type_a', 'rabbit', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_han_sk', '상무님이봐요', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_baek_coupang', '로켓배송중', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_woo_baemin', '배달비가아까워', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_shin_toss', '토스뱅커에요', 'type_a', 'rabbit', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_ahn_carrot', '당근이세요', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_jang_krafton', '배그하고싶다', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_ryu_nexon', '메이플키우기', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_moon_ncsoft', '리니지좀그만', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_ko_cjenm', '막내PD입니다', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_yang_lotte', '롯데카드멤버', 'type_a', 'rabbit', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_bae_gs', '편의점사장님', 'type_a', 'rabbit', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_hong_shinhan', '대출상담사', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_nam_posco', '철강왕후보생', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_hr_bot', '인사봇', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_sales_bot', '영업봇', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_night_owl', '올빼미NPC', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_intern_bot', '인턴봇', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_cs_bot', 'CS봇', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_weekend_bot', '주말알바NPC', 'type_a', 'mong', '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');

-- Step 4: Game score history (past 28 days, max 3/hour, max 6/day)
-- All score IDs prefixed seed_gsc_ / npc_gsc_ for easy identification
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_130da76689654fe09de5c60d197430aa', 'seed_usr_kim_daeri', '2048', 14269, '2026-06-15T04:04:25.031Z', 40, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_26cac4a36a824a669c86f1bfb871f618', 'seed_usr_kim_daeri', '2048', 18609, '2026-06-15T04:16:28.977Z', 120, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6c531f50f84143d297e6dd67cc6f65d6', 'seed_usr_kim_daeri', '2048', 15931, '2026-06-15T04:12:00.717Z', 129, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bf591f2713aa4f7c8e86b622eeb2f88c', 'seed_usr_kim_daeri', '2048', 15367, '2026-06-15T05:28:38.656Z', 157, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_17b2d63c35214836a137c4f72ab2d28a', 'seed_usr_kim_daeri', '2048', 13834, '2026-06-16T03:25:50.991Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_65c13ae19d16436ebe0c01fd43767811', 'seed_usr_kim_daeri', '2048', 13274, '2026-06-16T03:35:29.576Z', 162, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_925b7aa158864c2d905641818567ecc1', 'seed_usr_kim_daeri', 'sudoku', 1223, '2026-06-16T03:39:47.124Z', 109, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_07fff718b9254f388ea1ba0fc8ceb568', 'seed_usr_kim_daeri', '2048', 18633, '2026-06-16T04:16:43.373Z', 151, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_dda843940d1c4a948d6ff8bf31e397b3', 'seed_usr_kim_daeri', '2048', 11494, '2026-06-17T03:25:47.559Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3924b12be3444827972082f3db6b57d0', 'seed_usr_kim_daeri', 'sudoku', 850, '2026-06-18T03:28:01.896Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ec38b7269bb249eba88792df5970aac4', 'seed_usr_kim_daeri', 'sudoku', 470, '2026-06-18T03:32:10.410Z', 232, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8bca02ed00c6487ebcbbdc2652a35d31', 'seed_usr_kim_daeri', '2048', 5402, '2026-06-19T03:13:00.300Z', 179, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_856ad284ed034fda8362595544d78bee', 'seed_usr_kim_daeri', 'sudoku', 1102, '2026-06-19T03:21:07.813Z', 279, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3fc93f4b47d3431aa2a03374b4e19757', 'seed_usr_kim_daeri', '2048', 7893, '2026-06-19T03:29:55.644Z', 170, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4e912001d42546bab87301cae3570e2b', 'seed_usr_kim_daeri', '2048', 9347, '2026-06-19T04:25:33.809Z', 153, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c8a76a9d2aa244e2bbf0cd718d5931c8', 'seed_usr_kim_daeri', 'sudoku', 761, '2026-06-22T03:26:22.305Z', 188, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0f7f4fe674e3463f81984bd6ae061e42', 'seed_usr_kim_daeri', '2048', 13145, '2026-06-23T04:43:37.930Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_059c0c7e6aa0452b9cd652182c4db2c1', 'seed_usr_kim_daeri', '2048', 10020, '2026-06-23T04:49:34.474Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ef1b4b66f56c4701825682a3b70bc219', 'seed_usr_kim_daeri', '2048', 13716, '2026-06-23T04:49:27.512Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_aaa9d5cda0ef42008c19159a2da11b88', 'seed_usr_kim_daeri', '2048', 15957, '2026-06-24T03:37:33.618Z', 173, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_72091152aab64c36a1926f55ddd28d4a', 'seed_usr_kim_daeri', '2048', 4467, '2026-06-24T03:42:08.155Z', 80, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8d5b0b45dafd40be9d5864f9cc6b575e', 'seed_usr_kim_daeri', '2048', 12265, '2026-06-24T03:55:03.616Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_86c00c9aa8824a36b03f5a565ba45ee4', 'seed_usr_kim_daeri', '2048', 13763, '2026-06-25T03:20:49.777Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d607f218257d4100bfee9fd83c5b326a', 'seed_usr_kim_daeri', 'sudoku', 1092, '2026-06-26T03:05:35.857Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_19c7ae741d034c5fb131ab75cef20c58', 'seed_usr_kim_daeri', '2048', 9768, '2026-06-29T03:12:45.447Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_387fb0b7f0184fad8244230639689e20', 'seed_usr_kim_daeri', 'sudoku', 866, '2026-06-29T03:20:24.459Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bcd5df5fca99438f9d2429276697f4cd', 'seed_usr_kim_daeri', '2048', 18896, '2026-06-29T03:32:18.962Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_34862a9ca1a04f6ba55c91a856ba527f', 'seed_usr_kim_daeri', '2048', 19224, '2026-06-29T04:34:19.954Z', 169, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4f1b73e1622e405ca5fcde8fb549606b', 'seed_usr_kim_daeri', '2048', 10174, '2026-06-30T04:19:30.226Z', 61, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0c2c0923c14d4f7695b0901573dc9d65', 'seed_usr_kim_daeri', '2048', 11563, '2026-06-30T04:23:50.952Z', 34, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3382c9848a26492e850348bea4582fee', 'seed_usr_kim_daeri', '2048', 15485, '2026-07-01T04:43:06.121Z', 64, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7434f9d833b94cc6b02996c903a623ca', 'seed_usr_kim_daeri', '2048', 4618, '2026-07-02T03:02:50.916Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8775779cbd5e41c08993766e5798b28e', 'seed_usr_kim_daeri', '2048', 17464, '2026-07-02T03:12:32.109Z', 92, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c83d886b599f4a39b9ebb3643703f9a3', 'seed_usr_kim_daeri', 'sudoku', 487, '2026-07-02T03:16:29.547Z', 198, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2277f9174862476fab93a0c38846334d', 'seed_usr_kim_daeri', '2048', 16395, '2026-07-02T04:34:14.915Z', 131, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6fc5b2eeaf4649ca81e779af96e03c19', 'seed_usr_kim_daeri', '2048', 15352, '2026-07-03T04:33:48.626Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_37a49ad7a02e4d1184525a9b5ba7c11c', 'seed_usr_kim_daeri', '2048', 15528, '2026-07-03T04:38:24.909Z', 31, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_85e614310c4645cf869005d139fa4162', 'seed_usr_kim_daeri', '2048', 11838, '2026-07-03T04:45:08.279Z', 148, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6e1f0caf2d064f12bd8011f4cfa33963', 'seed_usr_kim_daeri', '2048', 7367, '2026-07-07T03:11:57.037Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a846cbaaec8148f2aff3fb4f684dba2f', 'seed_usr_kim_daeri', '2048', 14997, '2026-07-07T03:17:37.128Z', 31, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_015b47f86d6b40ae860cd9da17124986', 'seed_usr_kim_daeri', '2048', 16450, '2026-07-07T03:21:36.587Z', 138, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_71e4c4b6508246e9b02eadadf2c11d39', 'seed_usr_kim_daeri', '2048', 5875, '2026-07-07T04:16:01.448Z', 122, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2dcb584121e54c659336aa46bf189a3e', 'seed_usr_kim_daeri', '2048', 11141, '2026-07-08T04:26:12.118Z', 171, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c5be88b356fb41c4bc0ee9c68292968d', 'seed_usr_kim_daeri', '2048', 6375, '2026-07-08T04:35:56.438Z', 150, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_11739ce6fe7644a4872dba918e3e6d1f', 'seed_usr_kim_daeri', 'sudoku', 890, '2026-07-08T04:42:25.706Z', 52, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_64c512b135c94e508ee0c7c953edd86b', 'seed_usr_kim_daeri', '2048', 10386, '2026-07-08T05:39:47.539Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e327cabc6ae046d8b709a16e161cfba1', 'seed_usr_kim_daeri', '2048', 10927, '2026-07-10T03:23:12.963Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_de3060d1d121460aa7c85b2e3956b7b1', 'seed_usr_kim_daeri', '2048', 11378, '2026-07-10T03:35:00.757Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d326f68dfc5847719c0eca29bf55ddbe', 'seed_usr_park_staff', 'sudoku', 555, '2026-06-15T06:21:01.601Z', 217, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b93548b854394c3c94923b7d7f696deb', 'seed_usr_park_staff', 'sudoku', 562, '2026-06-15T06:30:50.422Z', 172, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_582a45ab65c94bd8bfc387bb94afb5e3', 'seed_usr_park_staff', 'sudoku', 375, '2026-06-16T06:34:48.205Z', 273, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e1e1746ee4a14593b4be800dff0bbd52', 'seed_usr_park_staff', 'sudoku', 349, '2026-06-16T06:40:23.630Z', 90, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d5558540c0184cc8a6746439112f21da', 'seed_usr_park_staff', 'sudoku', 251, '2026-06-16T06:50:15.563Z', 271, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e3190194cb62459e88f2518ad85af89b', 'seed_usr_park_staff', 'sudoku', 687, '2026-06-17T06:36:47.276Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5a37e4b77390467d8c151aa7d4b1bab9', 'seed_usr_park_staff', '2048', 4621, '2026-06-17T06:47:43.534Z', 160, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5b77f1bb08784e9da06728f3f31c8043', 'seed_usr_park_staff', 'sudoku', 307, '2026-06-17T06:46:20.081Z', 167, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_79cee4ae270c48a1a13a403e56346346', 'seed_usr_park_staff', 'sudoku', 638, '2026-06-18T06:19:34.038Z', 220, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6b7dfb8c7be046379689713925c756d4', 'seed_usr_park_staff', 'sudoku', 765, '2026-06-18T06:30:06.012Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e442ab1cde2f4bbf8f7cd0897756c9c8', 'seed_usr_park_staff', 'sudoku', 489, '2026-06-18T06:29:20.916Z', 198, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_93d1424cbc1c45f8b24a77f5d0435a00', 'seed_usr_park_staff', '2048', 8977, '2026-06-19T07:37:45.049Z', 138, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0a0b957668554c669df13be320a1873d', 'seed_usr_park_staff', 'sudoku', 561, '2026-06-19T07:49:40.081Z', 200, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_10fc757474814ea7b047246977c977e7', 'seed_usr_park_staff', 'sudoku', 795, '2026-06-22T06:44:15.951Z', 105, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b048ccdd11864f7bb34ed30f7e2abeed', 'seed_usr_park_staff', 'sudoku', 589, '2026-06-22T06:50:26.956Z', 115, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3ff8f3d756ff4f65830f9be6bfaf6f39', 'seed_usr_park_staff', 'sudoku', 768, '2026-06-22T06:59:23.392Z', 184, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_642c8974798741258869e3eb097daab5', 'seed_usr_park_staff', '2048', 10878, '2026-06-29T07:27:54.418Z', 152, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e93bdc8bb19a48c7ad5fa97f68ae50b3', 'seed_usr_park_staff', 'sudoku', 267, '2026-07-02T06:01:17.322Z', 194, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4fb36e584bbb4ef38e9c4feacea0cf61', 'seed_usr_park_staff', 'sudoku', 718, '2026-07-02T06:10:09.001Z', 233, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5c97cd45f37b47fba7212b263eb51136', 'seed_usr_park_staff', '2048', 10349, '2026-07-03T07:38:40.910Z', 61, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b0be437153f842a4ad5cb74fba761303', 'seed_usr_park_staff', 'sudoku', 810, '2026-07-06T06:20:53.631Z', 126, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d5d44f2dfd234ce4b29e847b8c969ddb', 'seed_usr_park_staff', 'sudoku', 814, '2026-07-06T06:30:45.541Z', 146, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e1186d7258d242c69dec754de6712ea8', 'seed_usr_park_staff', '2048', 5936, '2026-07-06T06:40:13.329Z', 141, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d43351f42c274ec28fbc4b1c7ae713a0', 'seed_usr_park_staff', '2048', 4660, '2026-07-07T07:30:38.259Z', 113, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f0370c4260cf44f9bca05fb52633b555', 'seed_usr_park_staff', '2048', 5656, '2026-07-07T07:39:40.726Z', 87, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_99243e470b4043b083ba44e3d89d8a48', 'seed_usr_park_staff', 'sudoku', 545, '2026-07-09T05:35:38.846Z', 176, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_62f7d2a6ffaa4f809058eae035153af9', 'seed_usr_park_staff', '2048', 5993, '2026-07-09T05:40:33.503Z', 79, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_76a9fa444de844ef90e1083850cef69d', 'seed_usr_park_staff', '2048', 7255, '2026-07-09T05:53:11.335Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b524f8f8235a497181514042af1e82b2', 'seed_usr_lee_manager', 'typing_game', 7099, '2026-06-15T00:02:03.608Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_67ce0d5929354215a78bd2f5f6134631', 'seed_usr_lee_manager', 'typing_game', 9256, '2026-06-16T01:32:42.302Z', 104, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ed614c43b047433cb2335c4f6cbe0ee7', 'seed_usr_lee_manager', '2048', 10563, '2026-06-16T01:36:53.106Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9609955d2b974cd798e130b4e49d9caf', 'seed_usr_lee_manager', '2048', 14501, '2026-06-17T01:01:43.107Z', 134, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_193e40c0603c4dd1a37bc64343f6ace8', 'seed_usr_lee_manager', 'typing_game', 7438, '2026-06-17T01:04:32.788Z', 103, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5e478e0cd516496ea8a2d0578d06dd9a', 'seed_usr_lee_manager', 'typing_game', 5067, '2026-06-17T01:11:17.069Z', 110, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b1da85d7f009466ba3c5d4495d6355f8', 'seed_usr_lee_manager', '2048', 19974, '2026-06-17T02:28:45.860Z', 163, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4600174f72f4491c95b016678ab55535', 'seed_usr_lee_manager', 'typing_game', 6093, '2026-06-19T00:08:49.202Z', 52, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_57f964f1408e4aaba9adaa132d2442e6', 'seed_usr_lee_manager', '2048', 15745, '2026-06-19T00:20:09.854Z', 137, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e0615317d97b4ec5b1bf9dc1705d752f', 'seed_usr_lee_manager', 'typing_game', 9786, '2026-06-22T01:14:42.300Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9e7bd637ae1945bc95f6c7e46de166d5', 'seed_usr_lee_manager', '2048', 5509, '2026-06-24T00:26:58.054Z', 41, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3504c6f81b6c4aceb97ac8e2648956cc', 'seed_usr_lee_manager', '2048', 18419, '2026-06-24T00:32:39.902Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a71a7732c58e4079a93d3952f1ea0c19', 'seed_usr_lee_manager', 'typing_game', 7479, '2026-06-24T00:32:35.437Z', 75, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3a77998317a04f5f84b7a56fe2f4b12a', 'seed_usr_lee_manager', '2048', 5170, '2026-06-25T00:17:02.833Z', 176, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bf016578706d4f29870e68360b9ee5fe', 'seed_usr_lee_manager', '2048', 17940, '2026-06-25T00:26:32.311Z', 131, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f9ac763ce0ca43e4a10a6af7651ec29b', 'seed_usr_lee_manager', 'typing_game', 9142, '2026-06-29T01:27:12.630Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5f18458c42334ed9bc7af5037c9f5757', 'seed_usr_lee_manager', '2048', 15556, '2026-06-30T00:20:25.083Z', 153, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6b6f218955a5482eab391132d3ccfe22', 'seed_usr_lee_manager', 'typing_game', 5644, '2026-06-30T00:25:20.076Z', 50, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4cb650ef9d6e4548a0d78582a44db59b', 'seed_usr_lee_manager', 'typing_game', 3047, '2026-07-07T00:07:32.396Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_41af6e3205a941918ad1ce7b644cea15', 'seed_usr_lee_manager', 'typing_game', 10525, '2026-07-07T00:19:15.700Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6de9e15e402a455c80fe25854cbe7536', 'seed_usr_choi_junior', 'sudoku', 447, '2026-06-15T08:14:39.903Z', 254, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_95056394d2004149aad2ab218c3c54e0', 'seed_usr_choi_junior', 'sudoku', 546, '2026-06-15T08:24:53.997Z', 147, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_91d96bc8cd8a4fcc92993e0519e8ace3', 'seed_usr_choi_junior', 'sudoku', 181, '2026-06-15T08:34:45.139Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f3e69bb4845846f3863601af2597e840', 'seed_usr_choi_junior', '2048', 5940, '2026-06-16T08:11:50.621Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_56d976a38c6449b3a0fa518027f93221', 'seed_usr_choi_junior', '2048', 6601, '2026-06-16T08:14:25.585Z', 178, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_62d8078411aa463eaab2e3e0276d7261', 'seed_usr_choi_junior', '2048', 7994, '2026-06-16T08:23:36.290Z', 64, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d6fe2375080a4439a54168087cd9767d', 'seed_usr_choi_junior', '2048', 3647, '2026-06-17T09:29:30.542Z', 154, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e1574b295ed64946ac416afd5a9d4e2b', 'seed_usr_choi_junior', '2048', 4082, '2026-06-19T08:15:32.279Z', 55, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2eb8ef6f803b4eb395b54779948dfc89', 'seed_usr_choi_junior', 'sudoku', 219, '2026-06-19T08:19:04.199Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a11502aa3f014cc3819ed804a8f67483', 'seed_usr_choi_junior', 'sudoku', 390, '2026-06-19T08:21:50.365Z', 174, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_71f963f778ee4faa81128358498f72ca', 'seed_usr_choi_junior', 'sudoku', 192, '2026-06-20T08:10:13.434Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_59603316145b4425a310e2d35df172b1', 'seed_usr_choi_junior', '2048', 5179, '2026-06-20T08:14:29.102Z', 145, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_de1aa92033fe4a07bde3838c325b7f22', 'seed_usr_choi_junior', 'sudoku', 310, '2026-06-20T08:32:29.563Z', 254, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_602c142ccfe8485980e0d2f20eeaf9ad', 'seed_usr_choi_junior', 'sudoku', 431, '2026-06-22T08:04:47.178Z', 197, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_53bf2edbe3dd49a3b379796138881fa5', 'seed_usr_choi_junior', '2048', 7601, '2026-06-22T08:08:19.088Z', 146, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4993fcb22dfb4cf29458b0bcb25cec5b', 'seed_usr_choi_junior', 'sudoku', 514, '2026-06-23T08:15:03.938Z', 284, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cab82c23e2164f6a96e86a87e40a5ed8', 'seed_usr_choi_junior', 'sudoku', 172, '2026-06-23T08:23:12.302Z', 282, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d516ac0f2e164312aa60493244a25be0', 'seed_usr_choi_junior', 'sudoku', 475, '2026-06-23T08:37:31.057Z', 84, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c7f2e86c275b4a5a83ae673cb587519c', 'seed_usr_choi_junior', '2048', 5515, '2026-06-25T08:29:02.411Z', 163, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1e633c1493ea4027928177632340de8f', 'seed_usr_choi_junior', '2048', 5133, '2026-07-01T08:17:57.364Z', 99, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_031fac75157648a0883f95b349bb4d9d', 'seed_usr_choi_junior', '2048', 5833, '2026-07-06T09:45:17.841Z', 164, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_de04a5b1c1a64711849114c50adecd6b', 'seed_usr_choi_junior', 'sudoku', 548, '2026-07-06T09:48:29.788Z', 212, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f2c3412465af4894bcaa31801b6a82bd', 'seed_usr_choi_junior', '2048', 5013, '2026-07-06T09:53:16.232Z', 173, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c2e917611b2a429dad278e32ac4d1678', 'seed_usr_choi_junior', '2048', 5360, '2026-07-11T09:09:04.461Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_48c5f834bbe14ac9b1e0855f530744ec', 'seed_usr_choi_junior', '2048', 2551, '2026-07-11T09:12:56.916Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9bdfb3fc7fe24751ab8f8790cfb7d10a', 'seed_usr_choi_junior', 'sudoku', 439, '2026-07-11T09:23:00.450Z', 58, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cea1b31bb53343e9b58f0e09fa5f87b3', 'seed_usr_choi_junior', '2048', 4576, '2026-07-12T08:42:11.740Z', 152, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_19808d9c109d43f29e9c8a270ee5e72f', 'seed_usr_choi_junior', '2048', 3245, '2026-07-12T08:49:48.074Z', 158, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3699764359c349beb28371f5e8f441e9', 'seed_usr_jung_intern', 'typing_game', 968, '2026-06-14T15:31:57.791Z', 75, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f67179bff29d4bec9b6dea76d6f98269', 'seed_usr_jung_intern', 'sudoku', 216, '2026-06-14T15:34:13.436Z', 179, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f7a23d6ebeb74ac8ba4e4dfab0a8892b', 'seed_usr_jung_intern', 'sudoku', 296, '2026-06-16T14:29:12.623Z', 234, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0a3c6b7a59f84461b277d80495ece1c8', 'seed_usr_jung_intern', 'typing_game', 2214, '2026-06-16T15:15:40.313Z', 46, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6f7fe81fcacc42109c039b2f6acf6713', 'seed_usr_jung_intern', 'typing_game', 2598, '2026-06-16T15:25:27.352Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_054bb41e12804f65a5fb52ec7ac62fff', 'seed_usr_jung_intern', 'typing_game', 1286, '2026-06-17T15:08:10.361Z', 120, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e1ac053c63fe47a7a167c98aecf0313f', 'seed_usr_jung_intern', 'typing_game', 1057, '2026-06-17T15:13:22.307Z', 71, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e08727be4dfc4ed0927ba8da43ad8de7', 'seed_usr_jung_intern', 'sudoku', 192, '2026-06-23T14:42:07.868Z', 237, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5072c15fe0e947aab9d5fee479acc074', 'seed_usr_jung_intern', 'sudoku', 217, '2026-06-23T14:46:53.958Z', 230, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cdda9477b8924c558eb36385e1e6aa91', 'seed_usr_jung_intern', 'typing_game', 2744, '2026-07-01T13:43:53.042Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_91b2ccf0310d46b5a11a0a4068cda7c3', 'seed_usr_jung_intern', 'sudoku', 100, '2026-07-02T14:14:17.620Z', 194, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3f4f26eb71cf48b9b8c6994ea4227d69', 'seed_usr_jung_intern', 'typing_game', 1975, '2026-07-02T14:18:32.812Z', 75, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_31b12237444b469b9a676ff6080db91e', 'seed_usr_jung_intern', 'sudoku', 197, '2026-07-05T13:09:34.184Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b307f5c2546d4036a23224e44df730f4', 'seed_usr_jung_intern', 'typing_game', 2394, '2026-07-06T15:13:59.130Z', 87, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0341dfd0b76d4fa283ac8f7fe704a214', 'seed_usr_jung_intern', 'typing_game', 2891, '2026-07-08T15:40:55.559Z', 40, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d017a3fff12a47eda1d60c065ef771da', 'seed_usr_jung_intern', 'sudoku', 206, '2026-07-08T15:45:03.103Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a77bc09b70ea44e0b3cc7553de707335', 'seed_usr_jung_intern', 'sudoku', 100, '2026-07-10T14:44:05.102Z', 207, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4beaa799d9d64c55bfadf827374c7cae', 'seed_usr_yoon_mgr', '2048', 18216, '2026-06-15T02:16:34.144Z', 163, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_80e6023aa2844cbe87bdf5eddd315b92', 'seed_usr_yoon_mgr', 'sudoku', 1457, '2026-06-16T02:31:41.310Z', 125, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9a4ad9ea44c047229354c531ee1615e2', 'seed_usr_yoon_mgr', 'sudoku', 1277, '2026-06-17T01:39:30.471Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_64b3b73579f24b22b1754c6f0f3468be', 'seed_usr_yoon_mgr', 'sudoku', 745, '2026-06-17T01:50:38.925Z', 219, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e70458f7fc94428da3fc6750f7cb6a65', 'seed_usr_yoon_mgr', '2048', 26853, '2026-06-18T01:23:53.375Z', 115, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_542601500bc64f8dbf0743031aed4c31', 'seed_usr_yoon_mgr', 'sudoku', 1196, '2026-06-18T01:27:17.003Z', 269, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b29fdeb1fb8142ffa7950a99bc0ef018', 'seed_usr_yoon_mgr', '2048', 12189, '2026-06-18T01:33:40.190Z', 92, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4c29954cf3b04683980932e8dd813e80', 'seed_usr_yoon_mgr', 'sudoku', 1337, '2026-06-18T02:29:07.323Z', 149, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9b0c2428bb00432dadfcd28321296e30', 'seed_usr_yoon_mgr', 'sudoku', 1082, '2026-06-18T02:53:17.507Z', 162, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e27918feb9cf4594bcae8c8e197f2b1b', 'seed_usr_yoon_mgr', 'sudoku', 1363, '2026-06-19T02:35:36.764Z', 131, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f71ef9db6dfc46a2ac868f4bec6a06df', 'seed_usr_yoon_mgr', 'sudoku', 1100, '2026-06-19T02:39:55.020Z', 204, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a56316358e7e499f81178f5515f32e3b', 'seed_usr_yoon_mgr', 'sudoku', 727, '2026-06-19T02:53:11.922Z', 135, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5f1312e235fe4a7da4b56d67125b3bfa', 'seed_usr_yoon_mgr', 'sudoku', 1172, '2026-06-19T03:40:01.337Z', 143, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a79ed71b5cbd45b5a549bd8616f7f585', 'seed_usr_yoon_mgr', '2048', 9510, '2026-06-19T03:29:59.968Z', 99, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0206d96025cb4a3c9d864df31be70101', 'seed_usr_yoon_mgr', 'sudoku', 790, '2026-06-23T01:09:33.878Z', 174, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0e779677601847ad8a89f5c77bbe22cf', 'seed_usr_yoon_mgr', 'sudoku', 1121, '2026-06-24T01:29:16.799Z', 273, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_424f65257d314acf80200df5c41b479e', 'seed_usr_yoon_mgr', '2048', 21964, '2026-06-24T01:34:19.615Z', 98, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4e209d5c6de044a5ae05cf7def3133b1', 'seed_usr_yoon_mgr', '2048', 26850, '2026-06-24T01:41:23.361Z', 161, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_77260044cec044c38ea5dda74b4481cc', 'seed_usr_yoon_mgr', 'sudoku', 1578, '2026-06-26T02:45:03.129Z', 158, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b041caa875d44df6b32849acf7a79fe8', 'seed_usr_yoon_mgr', 'sudoku', 1056, '2026-06-30T01:23:26.279Z', 63, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8289ef6692164591a67a93688f9c669d', 'seed_usr_yoon_mgr', 'sudoku', 1136, '2026-06-30T01:28:08.632Z', 249, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_17db1dec3a1049849783f8b0b0785a31', 'seed_usr_yoon_mgr', 'sudoku', 706, '2026-07-02T02:25:49.068Z', 65, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cc4ce9e5535148ff881ac86ab285114a', 'seed_usr_yoon_mgr', '2048', 14191, '2026-07-02T02:33:13.975Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fdca48e5860447009841b20656fb412c', 'seed_usr_yoon_mgr', '2048', 9812, '2026-07-02T02:39:29.513Z', 115, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_71eb3010943447cdb59b59b7f3911b60', 'seed_usr_yoon_mgr', 'sudoku', 737, '2026-07-06T01:09:24.096Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_05067a44bda84bee82cf414d1fcd312f', 'seed_usr_yoon_mgr', '2048', 27237, '2026-07-06T01:19:03.607Z', 143, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ddc260b15de94bc486e8bc87eb47b488', 'seed_usr_yoon_mgr', 'sudoku', 1194, '2026-07-06T01:21:21.227Z', 212, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fcee9ba768ee47f88d81c40baa2c37c9', 'seed_usr_yoon_mgr', '2048', 13062, '2026-07-06T02:25:20.680Z', 83, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7267ac676c6040d3a705a459404043d9', 'seed_usr_yoon_mgr', 'sudoku', 1065, '2026-07-07T01:45:15.987Z', 107, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_28f71affb4084144aabfea2f7a41b72e', 'seed_usr_yoon_mgr', 'sudoku', 844, '2026-07-08T02:21:47.485Z', 269, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0fd4a98370a44ac0b81ebd17c1615a6d', 'seed_usr_yoon_mgr', '2048', 14251, '2026-07-08T02:25:29.274Z', 131, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_41a577e6443242958a15131bc9b43eb8', 'seed_usr_yoon_mgr', 'sudoku', 1504, '2026-07-08T02:35:05.057Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ff9ec02502054de680f3bda12e0a1320', 'seed_usr_yoon_mgr', 'sudoku', 801, '2026-07-08T03:38:15.448Z', 225, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9cb13ae439f44217bfa1889f485658b6', 'seed_usr_yoon_mgr', 'sudoku', 964, '2026-07-08T03:36:23.099Z', 240, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5bd3c4d3fc9b4e1aa03716287c8fb47a', 'seed_usr_yoon_mgr', 'sudoku', 874, '2026-07-09T01:07:18.643Z', 222, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7a0d3d1b5c7f484298d9171d180f50c0', 'seed_usr_yoon_mgr', 'sudoku', 1235, '2026-07-09T01:11:55.370Z', 64, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_437b38ba485f4752ad1c7c6d773287ab', 'seed_usr_yoon_mgr', '2048', 10382, '2026-07-09T01:23:34.873Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7405f805be5b4c63a27572035735be9a', 'seed_usr_yoon_mgr', 'sudoku', 1324, '2026-07-09T02:31:33.507Z', 69, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c9fc13dc8eff4522bce4fd94b819328f', 'seed_usr_yoon_mgr', 'sudoku', 1113, '2026-07-10T02:35:37.653Z', 123, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f04c4f1ae23c4e198ac5b1f65f08daff', 'seed_usr_yoon_mgr', '2048', 11623, '2026-07-10T02:44:17.496Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5586f7f2e35b4fa18d073aea7d43e24f', 'seed_usr_yoon_mgr', 'sudoku', 1230, '2026-07-10T02:59:10.817Z', 78, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4e4192decf5c4e00a7bdb7837a7f30f7', 'seed_usr_yoon_mgr', 'sudoku', 1532, '2026-07-10T03:27:38.715Z', 211, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a825b15adb994003aea904f1f6a83898', 'seed_usr_yoon_mgr', '2048', 8824, '2026-07-10T03:29:27.346Z', 34, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_202b6a6cdf7449269205f8c5d63a4099', 'seed_usr_oh_lead', 'sudoku', 1599, '2026-06-15T04:01:06.645Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2aebf0025279432e9f652fed56530f1f', 'seed_usr_oh_lead', 'typing_game', 6275, '2026-06-15T04:12:07.146Z', 61, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4e78f1c52add4d5ab686987ff316cb84', 'seed_usr_oh_lead', 'sudoku', 1426, '2026-06-15T04:25:24.667Z', 123, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_133d7d4d13c74e24b3b11f013f736916', 'seed_usr_oh_lead', 'typing_game', 9875, '2026-06-15T05:16:29.086Z', 83, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ca266f04d2844e67a5faca529063fe98', 'seed_usr_oh_lead', 'sudoku', 956, '2026-06-15T05:28:59.824Z', 174, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9182a6e16c2948c480973707bca1b7eb', 'seed_usr_oh_lead', 'typing_game', 7145, '2026-06-17T05:15:46.709Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_32ed4dd43612440aae561f37669cafea', 'seed_usr_oh_lead', 'sudoku', 1339, '2026-06-17T05:21:23.685Z', 254, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f6bbe5b198984b79a8f3dcd436acf65b', 'seed_usr_oh_lead', 'typing_game', 6263, '2026-06-17T05:27:15.554Z', 49, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_935f5b5d94304c05b04cadc7de36aae2', 'seed_usr_oh_lead', 'typing_game', 7998, '2026-06-17T06:16:25.677Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_53d0ee07957d4e01a297d1d5f395a33f', 'seed_usr_oh_lead', 'sudoku', 784, '2026-06-17T06:28:05.207Z', 276, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0ce986df4f8b463c9a2d0840a10145d1', 'seed_usr_oh_lead', 'typing_game', 13584, '2026-06-18T04:12:39.849Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_431c3cb13f424a36be92c8893ab128ac', 'seed_usr_oh_lead', 'typing_game', 12349, '2026-06-18T04:24:55.756Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6c93f87c26724094869fa90f885a1068', 'seed_usr_oh_lead', 'sudoku', 1210, '2026-06-18T04:32:50.480Z', 204, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ad4fc66b83c349e398e7461e873efd93', 'seed_usr_oh_lead', 'typing_game', 8048, '2026-06-19T05:25:11.488Z', 90, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9fb27aa6e5dc469385ca33118c401d76', 'seed_usr_oh_lead', 'typing_game', 9296, '2026-06-19T05:31:44.558Z', 78, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_70700b6333bf4325841212ef7f14ea75', 'seed_usr_oh_lead', 'sudoku', 1341, '2026-06-19T05:43:54.665Z', 256, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_184fecaffcc44e8cae2c39de25dfd97e', 'seed_usr_oh_lead', 'typing_game', 13413, '2026-06-22T04:34:59.883Z', 77, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e4ed7439235845fe8863bf96693807b7', 'seed_usr_oh_lead', 'sudoku', 1242, '2026-06-23T05:45:29.847Z', 220, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cc3cf636ee694f38a5a14529d74d88c8', 'seed_usr_oh_lead', 'typing_game', 11865, '2026-06-23T05:51:27.417Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2efec64d478c4f9a88f5f49165ee4bfa', 'seed_usr_oh_lead', 'typing_game', 7724, '2026-06-23T05:59:07.790Z', 81, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fcd6d6c37b154e538fb9cb9192a0536a', 'seed_usr_oh_lead', 'typing_game', 12160, '2026-06-23T06:29:14.837Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6d21b1ba68894c4da6688dbb3d483a17', 'seed_usr_oh_lead', 'typing_game', 7007, '2026-06-24T05:15:23.791Z', 88, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9db6c7e00c844eeeb8189bb0c7577bd0', 'seed_usr_oh_lead', 'typing_game', 13323, '2026-06-24T05:26:17.328Z', 45, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e62d623049ab4e2f8443ad6629a30291', 'seed_usr_oh_lead', 'typing_game', 8411, '2026-06-25T04:19:19.365Z', 114, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d754fda025b24a90977a7ec50b4f7acf', 'seed_usr_oh_lead', 'typing_game', 11203, '2026-06-25T04:25:31.568Z', 86, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_283d3d999d31472ba4b36e1138cc6e93', 'seed_usr_oh_lead', 'sudoku', 796, '2026-06-25T04:35:27.559Z', 209, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_83f2162112954de498a218147f697e48', 'seed_usr_oh_lead', 'typing_game', 7165, '2026-06-25T05:38:04.736Z', 43, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_55108305c01646c8a9a8d90187b56f67', 'seed_usr_oh_lead', 'typing_game', 6241, '2026-06-25T05:53:01.186Z', 55, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4fe76d1e79cf402596cec18c623e4466', 'seed_usr_oh_lead', 'typing_game', 8190, '2026-06-30T05:16:38.090Z', 113, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cd44ce03203b4a17a7ed60aff667863a', 'seed_usr_oh_lead', 'typing_game', 10001, '2026-06-30T05:25:17.069Z', 77, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5093eb1a2f614431b28f4b36ba56dc16', 'seed_usr_oh_lead', 'typing_game', 7875, '2026-06-30T05:36:56.164Z', 45, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8092253a00304c1f9e5881e2c7c6e9d3', 'seed_usr_oh_lead', 'sudoku', 1143, '2026-07-01T04:31:36.115Z', 50, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7c24167e91df41269732dadc17cd368e', 'seed_usr_oh_lead', 'typing_game', 13659, '2026-07-01T04:39:29.799Z', 48, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_68f6c24b56c24baf98180dd836d1151e', 'seed_usr_oh_lead', 'typing_game', 4589, '2026-07-01T04:55:18.655Z', 59, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1661c5670c0f4d8489aae0b0593ed700', 'seed_usr_oh_lead', 'sudoku', 741, '2026-07-03T04:02:43.672Z', 172, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_420ba27de64641518e2813a5fc494653', 'seed_usr_oh_lead', 'sudoku', 1278, '2026-07-03T04:11:24.229Z', 283, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d67e2857854341378ba5a0a019bd0420', 'seed_usr_oh_lead', 'typing_game', 7569, '2026-07-03T04:20:07.128Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_15081615bf4e4923818b69598d155ec1', 'seed_usr_oh_lead', 'sudoku', 968, '2026-07-03T05:18:14.807Z', 46, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5b9da7e9acd54e2b81f0a4ef491caf97', 'seed_usr_oh_lead', 'sudoku', 1600, '2026-07-06T04:31:08.452Z', 266, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d772a7424e3d4d2f975dab46c61d5bbd', 'seed_usr_oh_lead', 'typing_game', 13159, '2026-07-07T04:04:45.757Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_07f9d4905ff74b1a975aef95c84a4cfe', 'seed_usr_oh_lead', 'sudoku', 1368, '2026-07-07T04:15:38.883Z', 241, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7d7ad43ccad34edabbb75e34e84b846a', 'seed_usr_oh_lead', 'typing_game', 10280, '2026-07-07T04:26:43.550Z', 120, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5042a18afc124f27b7ef664c659ee5e8', 'seed_usr_oh_lead', 'typing_game', 13455, '2026-07-07T05:16:03.938Z', 40, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b8f598d96472421e9222b7fc203c12df', 'seed_usr_oh_lead', 'sudoku', 1495, '2026-07-08T05:14:01.458Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_653ba21d6d1649e9a277a0120d020a42', 'seed_usr_oh_lead', 'typing_game', 10155, '2026-07-08T05:24:29.937Z', 83, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c3036078c3ab46a5b060c107843a83a1', 'seed_usr_oh_lead', 'typing_game', 11018, '2026-07-08T05:28:07.822Z', 41, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3a11e368c9514189a12e6ed626b8a2c9', 'seed_usr_oh_lead', 'typing_game', 12917, '2026-07-10T05:42:02.609Z', 116, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_72ccfe3783df4e5086dccfca77d31fed', 'seed_usr_oh_lead', 'typing_game', 7166, '2026-07-10T05:53:05.421Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d82b30b0b46143b4ae5350ec69e8dbd8', 'seed_usr_oh_lead', 'sudoku', 1492, '2026-07-10T05:58:57.556Z', 170, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3f67ed3383384901a52767a78bcd42f9', 'seed_usr_oh_lead', 'typing_game', 6329, '2026-07-10T06:37:34.818Z', 63, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_64279c74d592468bb7207590397c27b9', 'npc_usr_qa_bot', '2048', 2099, '2026-06-15T02:23:30.690Z', 170, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f184fac217714704860c3146a9b61ca4', 'npc_usr_qa_bot', 'typing_game', 1688, '2026-06-15T02:27:15.324Z', 54, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f0b7e1d410de4c0da538f2a645521afc', 'npc_usr_qa_bot', 'typing_game', 5510, '2026-06-15T02:31:14.335Z', 40, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_757d948e77f747fda1a7125317df4d0b', 'npc_usr_qa_bot', 'typing_game', 5929, '2026-06-15T03:22:54.912Z', 50, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_75c27d082dd34f549cb67cd10ec09a0e', 'npc_usr_qa_bot', 'typing_game', 1815, '2026-06-15T03:39:32.460Z', 113, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_bde1a4e543d8407e89a3d73feae8be15', 'npc_usr_qa_bot', 'typing_game', 7425, '2026-06-15T03:57:23.103Z', 102, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7172353093294a2d9a71373654c7a5c4', 'npc_usr_qa_bot', 'typing_game', 5037, '2026-06-17T07:42:43.194Z', 65, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_2b4ead03a70246ada02b77509044fd11', 'npc_usr_qa_bot', 'typing_game', 1041, '2026-06-17T07:50:59.819Z', 40, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a1a4f593fdc34bb5b00d9b1a705fbded', 'npc_usr_qa_bot', 'typing_game', 2113, '2026-06-19T07:01:23.963Z', 111, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_93552e7f95c64c1d8ef41b4d7e1cd404', 'npc_usr_qa_bot', 'typing_game', 2042, '2026-06-19T07:06:49.146Z', 81, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9ad120ba76b84ca08f59647e9155af54', 'npc_usr_qa_bot', 'typing_game', 5601, '2026-06-19T07:15:40.416Z', 105, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_91da8a7d0cc0463483cd8978e0ea7c7d', 'npc_usr_qa_bot', 'typing_game', 897, '2026-06-19T08:26:28.151Z', 103, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_27c4e349d97a4fe9bd47db2e4a60777e', 'npc_usr_qa_bot', '2048', 4661, '2026-06-19T08:59:58.214Z', 156, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d8949e84034641cfa39bba3c2b72263a', 'npc_usr_qa_bot', 'typing_game', 2908, '2026-06-19T08:59:56.473Z', 57, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ff835c6befe14d2ab18b5e02a88678d1', 'npc_usr_qa_bot', 'typing_game', 6350, '2026-06-24T05:38:45.779Z', 109, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_fe1d8e0971a04bf082c752c79699e868', 'npc_usr_qa_bot', 'typing_game', 6312, '2026-06-24T05:45:57.112Z', 61, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5cbba7cad4f34e79b0404379ce7dda5b', 'npc_usr_qa_bot', 'typing_game', 2369, '2026-06-26T01:42:32.115Z', 42, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_89f90e49d69e4d479b1b38fb827791be', 'npc_usr_qa_bot', '2048', 4658, '2026-06-26T01:52:48.566Z', 35, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_00fe4f53d1974aecac87110d9d838c75', 'npc_usr_qa_bot', 'typing_game', 2593, '2026-06-26T01:54:10.159Z', 72, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_8b6ace9aaeb244968b30d668dadd1910', 'npc_usr_qa_bot', '2048', 5066, '2026-06-29T01:45:30.087Z', 53, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_153baffb9e5544ecbe5bc2219bbed21a', 'npc_usr_qa_bot', '2048', 7179, '2026-06-29T01:52:05.464Z', 119, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a91a03ba650f47bbacaa6cdfdb4795cd', 'npc_usr_qa_bot', 'typing_game', 4252, '2026-06-29T01:51:01.519Z', 105, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b84ac16ad9b34d48a26c87c447995f6b', 'npc_usr_qa_bot', 'typing_game', 4552, '2026-06-29T02:21:52.295Z', 73, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_4b6d219b02f143af9c29556b1e3ddd56', 'npc_usr_qa_bot', 'typing_game', 1061, '2026-07-01T02:36:15.835Z', 64, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_063f6e2ac2704e1cae879363dc902b63', 'npc_usr_qa_bot', 'typing_game', 7204, '2026-07-01T02:40:00.406Z', 103, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7e7291fb7a5b44b6b40577e4e1aa9d48', 'npc_usr_qa_bot', 'typing_game', 6712, '2026-07-01T02:44:15.732Z', 45, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_263f0456d4054a47ae684e4dd851f4dd', 'npc_usr_qa_bot', 'typing_game', 5806, '2026-07-01T03:13:31.545Z', 103, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_2fd1bb6230e5497ba69a3971ef7db4ab', 'npc_usr_qa_bot', 'typing_game', 4116, '2026-07-03T02:44:42.485Z', 111, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_93e7eb3b1eb948b3ac811b1daba5c7e1', 'npc_usr_qa_bot', 'typing_game', 3121, '2026-07-03T02:50:41.460Z', 75, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_93d80f9a74944d379a01737a866b5ee1', 'npc_usr_qa_bot', 'typing_game', 3622, '2026-07-03T02:52:24.519Z', 116, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_be43560c27324dfc85d5c21d4b53b357', 'npc_usr_qa_bot', 'typing_game', 4983, '2026-07-08T05:15:30.661Z', 99, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_44f65d84da564de58189ff0fe82da0de', 'npc_usr_qa_bot', 'typing_game', 6827, '2026-07-10T01:19:13.751Z', 93, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_91e6b9f9cff342cc92ee065e74dd7641', 'npc_usr_qa_bot', 'typing_game', 4492, '2026-07-10T01:30:02.071Z', 91, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ffc33fce508240128b4c4eb12cf8daab', 'npc_usr_kim_daeri', '2048', 6481, '2026-06-15T02:03:58.366Z', 157, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_8783318d49e94003b0f80eb41389cd7a', 'npc_usr_kim_daeri', '2048', 1459, '2026-06-15T02:07:04.135Z', 103, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b5401ef3e81f4481a90bd46f53a65856', 'npc_usr_kim_daeri', 'sudoku', 782, '2026-06-15T02:17:18.481Z', 81, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_07bf4fa16cfe401a8adf75e5e671062b', 'npc_usr_kim_daeri', '2048', 8057, '2026-06-18T02:36:49.303Z', 149, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c20c7106d52044cdb5d75d51b70da4c5', 'npc_usr_kim_daeri', '2048', 4432, '2026-06-18T02:45:10.792Z', 123, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f9eedcff55ac4a20aaf27f9d40d2dc54', 'npc_usr_kim_daeri', 'sudoku', 365, '2026-06-18T02:48:22.385Z', 235, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_095219f078cf46949e35867474c93b15', 'npc_usr_kim_daeri', '2048', 6926, '2026-06-21T02:06:18.897Z', 162, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_af9c3653025e4ecbbaa6b42432cf576d', 'npc_usr_kim_daeri', '2048', 8072, '2026-06-21T02:14:17.930Z', 120, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0d33e6ff66e54a969c1fd3ccbd387ec9', 'npc_usr_kim_daeri', 'sudoku', 831, '2026-06-21T02:12:03.165Z', 108, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_674cea7118a2462a81a09e421289b5ec', 'npc_usr_kim_daeri', '2048', 6121, '2026-06-24T02:39:43.272Z', 67, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7d61af197f644d609e2e83bfa00cabb0', 'npc_usr_kim_daeri', '2048', 8475, '2026-06-24T02:45:09.586Z', 163, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b6f13a6765234bc38191a94f4edf8ac5', 'npc_usr_kim_daeri', 'sudoku', 851, '2026-06-24T02:59:30.568Z', 53, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_3a49162a309143099b907bc4f7754f15', 'npc_usr_kim_daeri', '2048', 6515, '2026-06-27T02:00:28.630Z', 34, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f6bd85482df245cf9ffc79bb72f55446', 'npc_usr_kim_daeri', '2048', 8392, '2026-06-27T02:06:01.644Z', 39, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_74d54e7030554f58bc08848488f96775', 'npc_usr_kim_daeri', 'sudoku', 255, '2026-06-27T02:14:32.010Z', 71, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6461a1a760f24ca99ea212dfae83bfcb', 'npc_usr_kim_daeri', '2048', 7933, '2026-06-30T02:45:07.186Z', 66, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e9a5b22a241a407fa7ab642f8ee9fa3d', 'npc_usr_kim_daeri', '2048', 9797, '2026-06-30T02:56:53.810Z', 124, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_4119a8d9ffad44ff954d62a46b58c0b3', 'npc_usr_kim_daeri', 'sudoku', 810, '2026-06-30T02:53:16.249Z', 91, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_71a0940c62414e358ec68a0f0d2d011e', 'npc_usr_kim_daeri', '2048', 1605, '2026-07-03T02:42:39.694Z', 145, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9b3d2fbc414a4bf4a88be7eef58034d5', 'npc_usr_kim_daeri', '2048', 1275, '2026-07-03T02:50:49.690Z', 127, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_db1ea2c6ae0b4a6fab406bf2b6828453', 'npc_usr_kim_daeri', 'sudoku', 529, '2026-07-03T02:56:31.025Z', 222, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_2b161968752e4db69d23aec0640a5615', 'npc_usr_kim_daeri', '2048', 8240, '2026-07-06T02:42:52.614Z', 104, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_60c707abc925445a8fe31a59c8d2b524', 'npc_usr_kim_daeri', '2048', 8450, '2026-07-06T02:53:44.928Z', 145, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_13aca68cdc9247a8b8f0e58d41948868', 'npc_usr_kim_daeri', 'sudoku', 304, '2026-07-06T02:59:05.044Z', 81, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_2c0669adfc2f442494988400711f2818', 'npc_usr_kim_daeri', '2048', 9945, '2026-07-09T02:15:38.350Z', 100, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5fc65f06faeb4c4fab943607d7c26829', 'npc_usr_kim_daeri', '2048', 4636, '2026-07-09T02:23:36.667Z', 172, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_94e90a8b473648bbaa8a5ae4e8454610', 'npc_usr_kim_daeri', 'sudoku', 677, '2026-07-09T02:35:54.883Z', 173, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0b9e5a43d766463983583941469f25f0', 'npc_usr_kim_daeri', '2048', 6906, '2026-07-12T02:18:13.624Z', 146, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a16f9843dc0c4596ae7a339adccd2bdb', 'npc_usr_kim_daeri', '2048', 3573, '2026-07-12T02:24:23.349Z', 63, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7eaab2f79d104fc39f1c1dfbf3ed5794', 'npc_usr_kim_daeri', 'sudoku', 370, '2026-07-12T02:24:34.409Z', 252, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ac72b9048f914a5ba475bbf4bb09a741', 'npc_usr_todaki', 'sudoku', 682, '2026-06-15T03:04:47.666Z', 272, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0d1af8c86f5e416e88e5b570bd43de1f', 'npc_usr_todaki', 'sudoku', 360, '2026-06-16T03:22:51.597Z', 46, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1ad826f2740a4118be7a51a9c19f74c6', 'npc_usr_todaki', '2048', 7564, '2026-06-18T04:43:50.343Z', 71, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6d615970f0ff43dcbb31d723e330321a', 'npc_usr_todaki', 'sudoku', 531, '2026-06-18T04:55:12.340Z', 117, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b8bbc665dac64d84bffea0b3fada61c0', 'npc_usr_todaki', '2048', 4261, '2026-06-23T03:09:57.781Z', 85, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_906bc4539f324b2fba9faf34cc3651d1', 'npc_usr_todaki', 'sudoku', 424, '2026-06-29T04:09:27.152Z', 171, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b8a21320aa7b42ae9d478fd53bfeebd1', 'npc_usr_todaki', 'sudoku', 816, '2026-06-30T03:36:48.618Z', 176, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_065561875ab6464e925140b5c37b84d9', 'npc_usr_todaki', 'sudoku', 559, '2026-06-30T03:47:02.888Z', 131, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1692d98a80454736b55959cd5baf918f', 'npc_usr_todaki', 'sudoku', 712, '2026-07-02T04:01:50.870Z', 271, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e537d0c8d3304e809c6a52929c326bfb', 'npc_usr_todaki', '2048', 2700, '2026-07-02T04:10:43.435Z', 34, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6faa0e53669340cd87154aa0b5d63ace', 'npc_usr_todaki', 'sudoku', 467, '2026-07-07T03:27:59.001Z', 276, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_498a973234044fd8b0447b93a32bb169', 'npc_usr_todaki', 'sudoku', 629, '2026-07-08T03:24:28.304Z', 280, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9412f9eaffb44e1c9c19bd4a9be31864', 'npc_usr_todaki', 'sudoku', 556, '2026-07-09T04:34:18.183Z', 193, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7c425eabfd2a463e9bd8f71828555e51', 'seed_usr_song_lg', 'typing_game', 2424, '2026-06-16T12:10:43.086Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0ff337de255848a8b21109df4d9060cb', 'seed_usr_song_lg', 'typing_game', 1564, '2026-06-19T12:03:59.076Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_165faa399b864a9d9fe840c48c5f90bd', 'seed_usr_song_lg', 'sudoku', 100, '2026-06-19T12:06:29.680Z', 85, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_38fdde00239a4901bfb84db9a868dd2f', 'seed_usr_song_lg', 'typing_game', 637, '2026-06-22T10:10:31.532Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_aa2420e3f7e84c7285915de679b0458f', 'seed_usr_song_lg', 'sudoku', 140, '2026-06-23T10:41:59.908Z', 289, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_704e58dc38714b899b0ee4cb88070635', 'seed_usr_song_lg', 'sudoku', 226, '2026-06-27T10:16:54.037Z', 258, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bbad0059f0e94a84838475fc71fb0933', 'seed_usr_song_lg', 'sudoku', 265, '2026-06-27T10:21:13.555Z', 134, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a74767f5757b42b79357d4903e168e89', 'seed_usr_song_lg', 'sudoku', 296, '2026-06-30T10:44:25.996Z', 291, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_33fdc3c12dd9466f98a91ac12db7a180', 'seed_usr_song_lg', 'sudoku', 100, '2026-06-30T10:49:02.409Z', 179, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_35483085c7b748a59928cc90982c39f1', 'seed_usr_song_lg', 'sudoku', 136, '2026-07-04T12:24:28.102Z', 156, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8bcf3c5c1b0541c1a618d2652ebe238a', 'seed_usr_song_lg', 'typing_game', 1914, '2026-07-04T12:30:50.040Z', 95, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_73ce28b3dfab480f9d460b01caf49f81', 'seed_usr_song_lg', 'sudoku', 147, '2026-07-05T10:21:27.601Z', 294, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2b2aa8751bb1449480654e530b53aa05', 'seed_usr_song_lg', 'typing_game', 2637, '2026-07-05T10:28:14.216Z', 103, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_757c832739784dea9bb221f2ebe66d0f', 'seed_usr_song_lg', 'typing_game', 2366, '2026-07-10T12:22:12.012Z', 81, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2b79b617d57b4e26acb0df1fdc7cfd8b', 'seed_usr_song_lg', 'typing_game', 1022, '2026-07-10T12:34:36.488Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8b7bc994aa214063a3c7e9f8d4c634fe', 'seed_usr_han_sk', '2048', 7176, '2026-06-16T03:18:47.608Z', 77, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1cd242e7ed77466a9abc08db2983836b', 'seed_usr_han_sk', 'sudoku', 439, '2026-06-16T03:26:49.694Z', 256, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_da90940404c5454daf5c50101df7dbe0', 'seed_usr_han_sk', '2048', 2062, '2026-06-17T03:12:47.760Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6a4764170de541949e431e333d9dd94a', 'seed_usr_han_sk', '2048', 7896, '2026-06-17T03:22:29.428Z', 53, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_617ab4bad6a04fb8bc78eac4c3f6737d', 'seed_usr_han_sk', '2048', 2640, '2026-06-17T03:32:35.635Z', 143, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e9c6c2cf48214215a0edd57aeb64545f', 'seed_usr_han_sk', '2048', 1863, '2026-06-18T02:44:34.683Z', 80, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_43db8f67505b45e38206d0f95cc85400', 'seed_usr_han_sk', '2048', 7585, '2026-06-18T02:51:27.039Z', 84, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_15e2d43968ef4fa8b20e65a728c1880c', 'seed_usr_han_sk', 'sudoku', 344, '2026-06-22T03:03:52.805Z', 196, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b1155fa2a4a8471193667770bdd4fe1e', 'seed_usr_han_sk', '2048', 2999, '2026-06-22T03:15:28.257Z', 75, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4ed39d91053a402b9726c246c65a3e23', 'seed_usr_han_sk', '2048', 1713, '2026-06-23T03:11:04.356Z', 117, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_40b00ca71a2d496882d75fe38e6ca362', 'seed_usr_han_sk', 'sudoku', 247, '2026-06-24T02:17:11.740Z', 101, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_968be4ac98064e1a83e9e903ee7710a9', 'seed_usr_han_sk', 'sudoku', 314, '2026-06-24T02:20:22.245Z', 53, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fce208a6437f44e699c0be6a83d1a2c5', 'seed_usr_han_sk', 'sudoku', 163, '2026-06-25T02:37:12.688Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c4163f3abb0b484d90b41ede55845601', 'seed_usr_han_sk', '2048', 5129, '2026-07-01T03:36:56.164Z', 69, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a404f74e2ca04ef9a5311a7a7b524474', 'seed_usr_han_sk', '2048', 5327, '2026-07-01T03:44:53.238Z', 89, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3dd09413339240b8900a242fc4504946', 'seed_usr_han_sk', '2048', 2432, '2026-07-02T03:05:57.276Z', 110, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_84044c887742466281506e598dc1cbf7', 'seed_usr_han_sk', '2048', 6086, '2026-07-02T03:08:20.015Z', 61, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f82932ef8ad1492ba76b4d6a4888f215', 'seed_usr_han_sk', '2048', 6634, '2026-07-03T02:30:28.110Z', 93, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f31187ea79d142588edae4dc2a4cb6d6', 'seed_usr_han_sk', '2048', 4359, '2026-07-03T02:39:43.295Z', 147, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2778ec2ece8d4c7987678564dfae2465', 'seed_usr_han_sk', 'sudoku', 251, '2026-07-06T03:28:50.148Z', 186, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b5bbc0c01cc048be8e6b127fe4da6946', 'seed_usr_han_sk', 'sudoku', 462, '2026-07-08T02:41:26.388Z', 79, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d3d05418221b444b8978fcfc741cd6ca', 'seed_usr_han_sk', '2048', 6589, '2026-07-09T03:39:45.061Z', 44, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ffb611412ad44295b82051ab8f1cadea', 'seed_usr_han_sk', 'sudoku', 151, '2026-07-10T02:08:07.802Z', 78, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1dc230e11977427b989b55d4a1154481', 'seed_usr_han_sk', 'sudoku', 299, '2026-07-10T02:11:24.056Z', 275, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8d92e2ac79c94b7aba7f62852d36a1bd', 'seed_usr_han_sk', '2048', 6709, '2026-07-10T02:30:20.449Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_99896582467346cb830d6ba7438d7213', 'seed_usr_baek_coupang', 'sudoku', 785, '2026-06-15T00:45:15.317Z', 170, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9258837e40124892bdf74a848a85c0f8', 'seed_usr_baek_coupang', 'sudoku', 604, '2026-06-15T00:49:28.487Z', 300, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b3254e730a0b42f9b5a8b785351453ad', 'seed_usr_baek_coupang', '2048', 7581, '2026-06-15T00:59:07.376Z', 81, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f219250a14194a8b9fd96864dc34eaa6', 'seed_usr_baek_coupang', 'sudoku', 281, '2026-06-16T00:25:49.412Z', 174, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0075eab5e9184cee9320d26afd14d4a0', 'seed_usr_baek_coupang', 'sudoku', 850, '2026-06-16T00:35:54.169Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d3d1ae86b6384934a41ba1bd5fccfde8', 'seed_usr_baek_coupang', '2048', 11245, '2026-06-17T00:11:10.985Z', 79, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_30b17ce29dbe4117ab154d6f23157a6d', 'seed_usr_baek_coupang', 'sudoku', 553, '2026-06-17T00:19:18.829Z', 177, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ed1dbfa78b584134bc02e609693fd7e0', 'seed_usr_baek_coupang', '2048', 4407, '2026-06-17T00:23:32.015Z', 158, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_779938cea53a4c108584e835f3682ce3', 'seed_usr_baek_coupang', '2048', 5451, '2026-06-18T00:00:47.690Z', 90, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_00caf5547942471eb821111e57b1125f', 'seed_usr_baek_coupang', '2048', 6264, '2026-06-18T00:11:46.716Z', 159, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_faac54e642d64620ac7a53134dde1242', 'seed_usr_baek_coupang', '2048', 8819, '2026-06-19T00:07:56.653Z', 172, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7b14df06ed3a42c1b33f1d31add77894', 'seed_usr_baek_coupang', '2048', 3732, '2026-06-19T00:12:45.761Z', 84, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3ee38373847e419fafc382f5638f170b', 'seed_usr_baek_coupang', '2048', 11209, '2026-06-20T01:11:59.384Z', 71, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_23cfd199193e4a8a9edaf7a80299d359', 'seed_usr_baek_coupang', 'sudoku', 353, '2026-06-22T00:04:56.187Z', 69, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e68e4e253ebe4287863783b38888b9dd', 'seed_usr_baek_coupang', '2048', 11206, '2026-06-24T00:17:29.956Z', 161, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8a0fa8f536954a689d16e48391713897', 'seed_usr_baek_coupang', '2048', 4279, '2026-06-24T00:22:32.949Z', 110, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_09d52dd99bf5453a931e903e8f263636', 'seed_usr_baek_coupang', '2048', 7265, '2026-06-27T00:26:26.613Z', 47, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_395958cbcc56412082e6b8d2bcaf923d', 'seed_usr_baek_coupang', 'sudoku', 843, '2026-06-27T00:34:16.677Z', 92, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a469665b99364cd1945938258f79115b', 'seed_usr_baek_coupang', '2048', 9542, '2026-06-28T00:08:07.231Z', 131, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d3335c0894664e32b85e6052e883e4fd', 'seed_usr_baek_coupang', '2048', 3446, '2026-06-28T00:20:14.636Z', 140, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f2a91368e690486282cad0ab22c014f7', 'seed_usr_baek_coupang', 'sudoku', 389, '2026-06-29T01:08:19.528Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_86fb73827ebd4203a5cd4bb396e8df23', 'seed_usr_baek_coupang', '2048', 8803, '2026-06-30T00:40:59.011Z', 161, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f1f98b87f4f14bcea98c35fb3a54c746', 'seed_usr_baek_coupang', 'sudoku', 648, '2026-06-30T00:50:13.299Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a200a027784f4a259df50c0e792bcfd5', 'seed_usr_baek_coupang', '2048', 6464, '2026-07-01T01:44:30.966Z', 159, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8c17edb4659640bb8a57107b8564d855', 'seed_usr_baek_coupang', 'sudoku', 594, '2026-07-01T01:52:56.630Z', 242, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4df3fca5fb7641b5a6a8d46acac59fc7', 'seed_usr_baek_coupang', 'sudoku', 340, '2026-07-01T01:59:24.525Z', 227, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d6a60965f35746fe8fb62f1e5c7b8097', 'seed_usr_baek_coupang', 'sudoku', 807, '2026-07-02T01:25:27.635Z', 98, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_315e5dc086ec42889055f5e24f427f1b', 'seed_usr_baek_coupang', 'sudoku', 523, '2026-07-05T01:40:21.176Z', 146, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_77c0450bd7bc4bd9a2de97ce17575d52', 'seed_usr_baek_coupang', '2048', 7795, '2026-07-05T01:44:06.446Z', 142, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_faf976876dc746b5a94966b4d4a01952', 'seed_usr_baek_coupang', '2048', 11029, '2026-07-05T01:48:58.749Z', 84, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6fd98d19503b490eaf960f7be8b6bd57', 'seed_usr_baek_coupang', 'sudoku', 395, '2026-07-06T01:21:02.836Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_33cb4ff1883845e1b6ca9693884a3565', 'seed_usr_baek_coupang', '2048', 4674, '2026-07-07T01:05:29.425Z', 101, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2427cb39482549dcaa93ad2c7283bcea', 'seed_usr_baek_coupang', 'sudoku', 551, '2026-07-07T01:15:28.013Z', 254, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3385b6686d644e82a5b8d242e69a7a4c', 'seed_usr_baek_coupang', '2048', 10071, '2026-07-07T01:27:46.003Z', 36, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7f91647e020e4549b1bb594d0c3e28c8', 'seed_usr_baek_coupang', '2048', 2925, '2026-07-09T01:20:04.416Z', 98, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ed6c049b46154220a4496be18339eb95', 'seed_usr_baek_coupang', '2048', 3623, '2026-07-09T01:23:37.615Z', 164, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4a28f3f26c334c50bf3677297e638d08', 'seed_usr_baek_coupang', 'sudoku', 291, '2026-07-10T01:10:54.763Z', 114, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a64628d6df8a41f68d6346f85445e920', 'seed_usr_baek_coupang', '2048', 6128, '2026-07-11T00:31:50.997Z', 153, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_98fc8bea95a54b15882483d1468cf80a', 'seed_usr_baek_coupang', 'sudoku', 743, '2026-07-11T00:36:56.739Z', 162, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_24b4d91d1bcb449689cc963fdea6d9a1', 'seed_usr_baek_coupang', '2048', 9812, '2026-07-12T00:04:23.673Z', 173, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_677114acd1c84101953a30461b49228b', 'seed_usr_baek_coupang', '2048', 10751, '2026-07-12T00:09:47.272Z', 96, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9e50962d9bb74acd89910c874db6d6bd', 'seed_usr_baek_coupang', 'sudoku', 863, '2026-07-12T00:20:12.464Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_df712394626e4047b718ef39ab42fc0c', 'seed_usr_woo_baemin', 'typing_game', 4772, '2026-06-17T09:12:12.146Z', 83, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_78f0088ea84f4dd99dcfda2a3fc46475', 'seed_usr_woo_baemin', '2048', 11364, '2026-06-17T09:23:58.322Z', 138, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2450491fd5dc460098aab33d939fe7af', 'seed_usr_woo_baemin', 'typing_game', 8784, '2026-06-18T09:33:48.621Z', 107, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_810d04167ff14278968eb9b70cd5be43', 'seed_usr_woo_baemin', 'typing_game', 7002, '2026-06-18T09:44:50.806Z', 99, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b2b9e280844c466aa7884ecbd7dda1c0', 'seed_usr_woo_baemin', 'typing_game', 9815, '2026-06-18T09:51:37.210Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_504b0472e1e74688aefe6d4fc1b898bc', 'seed_usr_woo_baemin', 'typing_game', 4999, '2026-06-18T10:40:23.882Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ecdf05e06eec480f9ff0879224444467', 'seed_usr_woo_baemin', '2048', 17989, '2026-06-23T09:44:33.897Z', 144, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_51de0933a5ac4180bde0c2b8ea6df104', 'seed_usr_woo_baemin', 'typing_game', 10673, '2026-07-01T09:41:03.989Z', 86, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_517a5daf81904da580e93a7de83bbcd2', 'seed_usr_woo_baemin', 'typing_game', 7660, '2026-07-01T09:47:38.397Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ad93bfce83d84d5abf7b3f3c04348504', 'seed_usr_woo_baemin', 'typing_game', 10847, '2026-07-03T10:21:44.156Z', 86, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_048103a5166043cbb594bc547027bbe5', 'seed_usr_woo_baemin', '2048', 13527, '2026-07-03T10:24:31.323Z', 148, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_61a6753c666b4aca959433b5a9555800', 'seed_usr_woo_baemin', 'typing_game', 10191, '2026-07-03T10:41:37.185Z', 69, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a8984d68daa84776871ec889676fb221', 'seed_usr_woo_baemin', 'typing_game', 5227, '2026-07-03T11:31:06.254Z', 65, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_af7cc61cb8924f26a836a6434cd61a70', 'seed_usr_woo_baemin', '2048', 19801, '2026-07-09T09:01:43.065Z', 133, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_37b93f19357140a9bd1ad77a4773c700', 'seed_usr_woo_baemin', 'typing_game', 4955, '2026-07-09T09:09:38.878Z', 112, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_666238c4246c41ebbeb78ea4cc38b1ec', 'seed_usr_woo_baemin', '2048', 12276, '2026-07-10T10:24:54.724Z', 163, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_adca038c1e934a3887b1b05728205aad', 'seed_usr_woo_baemin', '2048', 16729, '2026-07-10T10:27:48.657Z', 125, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d33e0cebe3644956999ae258030f436b', 'seed_usr_shin_toss', 'sudoku', 1250, '2026-06-17T02:16:32.298Z', 65, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_096724cfc87c4b11b42eb1e7d7e0334e', 'seed_usr_shin_toss', 'sudoku', 1448, '2026-06-17T02:22:16.820Z', 144, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fe5d5e3abde7478ea9fde471b298a9f6', 'seed_usr_shin_toss', 'sudoku', 1608, '2026-06-17T02:34:59.531Z', 146, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_74b342c73fc44320b18729d73e94c7c8', 'seed_usr_shin_toss', 'sudoku', 1444, '2026-06-19T01:10:15.471Z', 297, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_09f49c456f3740df8d057e529a9da8cd', 'seed_usr_shin_toss', 'sudoku', 1122, '2026-06-19T01:17:31.311Z', 89, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_40200633be54428fb6a479b09af0f7a5', 'seed_usr_shin_toss', 'sudoku', 1483, '2026-06-19T01:24:34.874Z', 143, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1da8405b44b34b99a06dc962e7fc102a', 'seed_usr_shin_toss', 'sudoku', 852, '2026-06-22T00:24:17.664Z', 238, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8dc011be92074a239e5bf786bcfb4845', 'seed_usr_shin_toss', 'sudoku', 1221, '2026-06-23T00:26:16.610Z', 144, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_18e545b6a4f94b27905ebd48a628da40', 'seed_usr_shin_toss', 'sudoku', 897, '2026-06-23T00:33:08.323Z', 221, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_42d4890d23964be88168ddaa6ecf1b97', 'seed_usr_shin_toss', 'sudoku', 1188, '2026-06-23T00:42:22.361Z', 169, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_83cad6a13c374ea0b3f9e0c95556d3ff', 'seed_usr_shin_toss', 'sudoku', 1011, '2026-06-23T01:21:10.245Z', 209, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f3496439c916430c9b275ab75ed4e4d1', 'seed_usr_shin_toss', 'sudoku', 740, '2026-06-24T00:41:40.089Z', 246, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3cd61de885d34f9883c3b9711548428a', 'seed_usr_shin_toss', 'sudoku', 1587, '2026-06-24T00:47:37.865Z', 132, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_89e031aed96a4e99a1f0bcad3760e30a', 'seed_usr_shin_toss', 'sudoku', 1224, '2026-06-24T00:59:08.284Z', 119, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_deab9a794e094b28ac898a4009ab0835', 'seed_usr_shin_toss', 'sudoku', 1554, '2026-06-24T01:16:09.150Z', 145, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d318ad4c992d42a9893b4fc81ee2f688', 'seed_usr_shin_toss', 'sudoku', 1466, '2026-06-24T01:25:43.237Z', 269, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c86932e2773f4349899fdabe5ca82fb1', 'seed_usr_shin_toss', 'sudoku', 1095, '2026-06-25T01:13:39.120Z', 148, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_be2c9ff4b67e4b2b8fcc546a45742e97', 'seed_usr_shin_toss', 'sudoku', 889, '2026-06-25T01:24:13.979Z', 255, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_89506fb3880446b49ecbe82c3736f9f3', 'seed_usr_shin_toss', 'sudoku', 715, '2026-06-25T01:27:45.722Z', 261, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b515e002cf3b48dc9330e4912e60a882', 'seed_usr_shin_toss', 'sudoku', 1190, '2026-06-25T02:40:29.795Z', 140, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bbcf3d2306e94ecea1e687b61c2c6f79', 'seed_usr_shin_toss', 'sudoku', 914, '2026-06-25T02:27:33.328Z', 167, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1db7e900c51e4632b3afd2f88047ef50', 'seed_usr_shin_toss', 'sudoku', 808, '2026-06-26T01:02:13.948Z', 297, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_01c976c0258c45a8bd1fb9301442b01a', 'seed_usr_shin_toss', 'sudoku', 1279, '2026-06-26T01:13:24.554Z', 258, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_341d22689392437795d0c03b9ca09f75', 'seed_usr_shin_toss', 'sudoku', 1004, '2026-06-26T01:24:57.912Z', 151, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0400f166cdfc4a46a866ded69d9aff7f', 'seed_usr_shin_toss', 'sudoku', 952, '2026-06-29T00:22:27.499Z', 195, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_92e0fccfa65a47e6ae2e69c0b4a0b647', 'seed_usr_shin_toss', 'sudoku', 721, '2026-06-29T00:26:46.583Z', 77, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_95f1404125e945d78d564b9adb99c649', 'seed_usr_shin_toss', 'sudoku', 1402, '2026-06-30T01:36:06.050Z', 162, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ab0b7a4d2cff497e835fc7b52c036f1e', 'seed_usr_shin_toss', 'sudoku', 993, '2026-06-30T01:45:42.924Z', 121, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3e271a15d9fb4d47b8ccc00cefd43c15', 'seed_usr_shin_toss', 'sudoku', 1614, '2026-07-01T01:02:55.644Z', 79, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_63ef31b0c925407e9eb6e6a88a0ad732', 'seed_usr_shin_toss', 'sudoku', 1037, '2026-07-01T01:05:08.427Z', 96, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bce76361c6604cb891662d0a143b9c70', 'seed_usr_shin_toss', 'sudoku', 935, '2026-07-01T01:20:34.056Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2638dee5fb2c4ad1a48f5c3448bca501', 'seed_usr_shin_toss', 'sudoku', 736, '2026-07-01T02:27:31.925Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_73c57cd7364c4f85a20369332aad3235', 'seed_usr_shin_toss', 'sudoku', 1536, '2026-07-03T01:26:48.538Z', 151, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_06f8aeb593de415087781f417ab76d25', 'seed_usr_shin_toss', 'sudoku', 827, '2026-07-06T00:45:27.273Z', 61, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2037221b370d4494aaaf46f9ee936073', 'seed_usr_shin_toss', 'sudoku', 1265, '2026-07-06T00:57:10.577Z', 154, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9de507b609fa453d909966d1ceea9df7', 'seed_usr_shin_toss', 'sudoku', 1247, '2026-07-06T00:57:29.644Z', 258, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_10ff0b0c96b54a4189b1489aec587a16', 'seed_usr_shin_toss', 'sudoku', 1507, '2026-07-08T01:38:24.565Z', 137, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f5e2a15c9e164f238b94ae18eaa089dc', 'seed_usr_shin_toss', 'sudoku', 1055, '2026-07-09T00:20:33.862Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_25c8e787f3a8430ca4422ee9857bc861', 'seed_usr_shin_toss', 'sudoku', 1343, '2026-07-10T00:34:40.319Z', 62, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9c1b06ef715c4d31bed9fdf57ff06375', 'seed_usr_shin_toss', 'sudoku', 1261, '2026-07-10T00:41:54.646Z', 135, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0e875a9782a54a608df7c2d906d4777c', 'seed_usr_shin_toss', 'sudoku', 898, '2026-07-10T00:52:40.563Z', 135, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a9f08b30f673476687f393c689a35876', 'seed_usr_shin_toss', 'sudoku', 802, '2026-07-10T01:30:54.488Z', 291, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_385ea0edddf34b15827dfca77ffb504f', 'seed_usr_shin_toss', 'sudoku', 774, '2026-07-10T01:20:27.318Z', 96, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_03ab84008af74990a95dc34f852ee71e', 'seed_usr_ahn_carrot', '2048', 2947, '2026-06-22T07:40:04.435Z', 159, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2e46cd23de1e4e2a8990ff034c9e5307', 'seed_usr_ahn_carrot', '2048', 1758, '2026-06-22T07:47:44.871Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_20e3db95bb6e41d0b3a099f4dd006edf', 'seed_usr_ahn_carrot', '2048', 2286, '2026-06-23T07:29:45.476Z', 126, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bea89981708d43c087707a7f86e3b73f', 'seed_usr_ahn_carrot', '2048', 1052, '2026-06-23T07:33:06.290Z', 149, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_78c552831c70480fbdaf8e9a4f67f638', 'seed_usr_ahn_carrot', '2048', 4890, '2026-06-24T07:06:29.302Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4d17361255ad49109d4a8edde70ea274', 'seed_usr_ahn_carrot', '2048', 4294, '2026-06-24T07:14:00.431Z', 130, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7b1aa6ebcf1d465da4d5cb151383bae3', 'seed_usr_ahn_carrot', '2048', 4757, '2026-06-26T07:20:28.095Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_60c249fac13f4c909f52610b609f2c50', 'seed_usr_ahn_carrot', '2048', 742, '2026-06-30T06:40:36.073Z', 160, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_942e84d793d94da687f9463b3956f5e8', 'seed_usr_ahn_carrot', '2048', 4936, '2026-06-30T06:52:18.134Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_414b389556524702b556e6a75814f5a2', 'seed_usr_ahn_carrot', '2048', 3143, '2026-07-04T06:28:14.758Z', 80, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b10d0e828fe246eea2de852915d05567', 'seed_usr_ahn_carrot', '2048', 3191, '2026-07-07T07:28:44.360Z', 33, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f40363fc966f4273ae001fc8437799bf', 'seed_usr_ahn_carrot', '2048', 4677, '2026-07-07T07:36:17.927Z', 36, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0e6930bc5cf7485abb3f7d43ef18d699', 'seed_usr_ahn_carrot', '2048', 869, '2026-07-09T06:43:21.537Z', 98, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_45aa0b5a22b0416ab8c8579375cd83cc', 'seed_usr_ahn_carrot', '2048', 1024, '2026-07-09T06:49:14.690Z', 162, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4f0b5aa7b3a5467bb0899fd2a4b66954', 'seed_usr_ahn_carrot', '2048', 3773, '2026-07-12T07:10:18.557Z', 145, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2010610c1b9b496ea7240c0cdfef4c58', 'seed_usr_ahn_carrot', '2048', 3379, '2026-07-12T07:16:21.123Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ea233d2b80a94da2b97922a0f8d178ea', 'seed_usr_jang_krafton', 'typing_game', 4438, '2026-06-18T05:20:27.838Z', 40, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_389a0d8461464445812f7f3b5b58e5de', 'seed_usr_jang_krafton', 'typing_game', 6691, '2026-06-18T05:28:47.562Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b87f940a7d044ab18952f4b410ad90c9', 'seed_usr_jang_krafton', '2048', 8676, '2026-06-23T04:38:34.732Z', 132, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9eb5d22e67e9435790aef363a99115c3', 'seed_usr_jang_krafton', '2048', 7682, '2026-06-23T04:45:21.386Z', 126, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_72f5fd1ae1414752937b0faab0449e8a', 'seed_usr_jang_krafton', '2048', 5695, '2026-06-23T04:56:04.196Z', 178, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_440ea0ed38614a69b4a020d8a5ab596d', 'seed_usr_jang_krafton', '2048', 7910, '2026-06-25T05:14:23.778Z', 48, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ee80b99f7e224f999d86316b8f349302', 'seed_usr_jang_krafton', '2048', 6734, '2026-06-25T05:24:43.540Z', 154, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_aad71b801a584df4baab65dba984ee74', 'seed_usr_jang_krafton', '2048', 11331, '2026-06-26T05:24:17.768Z', 91, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9e67c43c4f674110b4cea32ae4a10b77', 'seed_usr_jang_krafton', '2048', 11034, '2026-06-29T05:36:38.766Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0d67929f7b4a4889b532577634a79d9d', 'seed_usr_jang_krafton', 'typing_game', 3055, '2026-06-29T05:42:10.703Z', 52, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cd462b85a0734a0e94b2a7ac7784609b', 'seed_usr_jang_krafton', 'typing_game', 3025, '2026-07-01T05:11:47.068Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_97482452b9314c4391b23ec13f7c7f76', 'seed_usr_jang_krafton', '2048', 5405, '2026-07-09T04:27:59.060Z', 83, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7c4d178bad044cf8a4fd98e77d1d4af7', 'seed_usr_jang_krafton', '2048', 3836, '2026-07-09T04:34:07.203Z', 93, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_af79ffcd004c47208640e1aac9ca1c7a', 'seed_usr_jang_krafton', '2048', 8273, '2026-07-10T04:43:50.040Z', 85, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d9397ff2187b4e71b7297ab5ea388811', 'seed_usr_ryu_nexon', '2048', 1707, '2026-06-15T13:11:35.194Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_32c69540037c4b5cbfaa77faa0373a26', 'seed_usr_ryu_nexon', '2048', 7048, '2026-06-16T11:43:20.762Z', 48, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_57009a173ed642a7b2d352d38e9fc05a', 'seed_usr_ryu_nexon', '2048', 6031, '2026-06-16T11:46:45.705Z', 158, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9d71d2a224a7442faebe886fec9ca588', 'seed_usr_ryu_nexon', '2048', 2321, '2026-06-17T11:34:47.263Z', 149, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0051427836d3494189f3bbf390942a9d', 'seed_usr_ryu_nexon', '2048', 3208, '2026-06-17T11:43:51.937Z', 173, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5c27b0c268b84c0985af16e914577257', 'seed_usr_ryu_nexon', '2048', 7165, '2026-06-20T12:28:14.581Z', 155, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_335e0d70d40546acb02f15b722c8162d', 'seed_usr_ryu_nexon', '2048', 3657, '2026-06-21T11:13:11.532Z', 130, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8b8c3303d3e549de850cab516d32ee75', 'seed_usr_ryu_nexon', '2048', 3520, '2026-06-21T11:23:39.695Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_71ef810f5d464b8cb113d46eceef0066', 'seed_usr_ryu_nexon', '2048', 4165, '2026-06-21T11:29:01.772Z', 93, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bec6eff124ca4b30a3eaf0bde739f736', 'seed_usr_ryu_nexon', '2048', 4329, '2026-06-22T11:11:19.719Z', 129, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0bc4a7445ccf42d884e6d99b01aad040', 'seed_usr_ryu_nexon', '2048', 6602, '2026-06-22T11:20:19.586Z', 149, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ee36499581f146b58d287491d4d0643c', 'seed_usr_ryu_nexon', '2048', 5941, '2026-06-22T11:27:44.485Z', 135, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0b64e159cd4f4e60a7cd510fd95089d7', 'seed_usr_ryu_nexon', '2048', 5842, '2026-06-23T11:24:10.153Z', 121, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0298d91464bb4f2d9e10018458e535bf', 'seed_usr_ryu_nexon', '2048', 5213, '2026-06-25T13:01:54.172Z', 155, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9387ad5460fb458ebf743aa2607714dc', 'seed_usr_ryu_nexon', '2048', 4422, '2026-06-28T11:45:41.587Z', 135, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_279d033ddafb44e391bdcf47e84a600a', 'seed_usr_ryu_nexon', '2048', 2417, '2026-06-28T11:48:13.087Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6becb2839e774993bd9840eaee3c1361', 'seed_usr_ryu_nexon', '2048', 4075, '2026-06-30T12:32:47.242Z', 63, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8408e7ac39854e89b7279bef1f235343', 'seed_usr_ryu_nexon', '2048', 5632, '2026-06-30T12:42:58.902Z', 95, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_274afbfc04b94a8d95590a37f0183512', 'seed_usr_ryu_nexon', '2048', 7606, '2026-07-03T12:14:05.572Z', 39, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ce455929a22c427394c30874dedca6d6', 'seed_usr_ryu_nexon', '2048', 4171, '2026-07-06T13:31:51.296Z', 98, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6242c38df96e4c0db0c5faad0df46061', 'seed_usr_ryu_nexon', '2048', 2140, '2026-07-06T13:39:50.375Z', 50, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fdfd855fd5ea4d8ebf7848ca0f72de99', 'seed_usr_ryu_nexon', '2048', 5758, '2026-07-06T13:45:21.219Z', 90, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7753031e203e4f16bedb8bac56fe390b', 'seed_usr_ryu_nexon', '2048', 1632, '2026-07-08T12:08:33.920Z', 36, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_966fa357919a43ef8104d30b3f16ae3d', 'seed_usr_ryu_nexon', '2048', 5094, '2026-07-08T12:16:58.786Z', 56, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_65b9a98a80ae479f83567bccbb78fd77', 'seed_usr_ryu_nexon', '2048', 4747, '2026-07-08T12:32:43.742Z', 63, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2d4f20016f8a494aa28d941779c68726', 'seed_usr_ryu_nexon', '2048', 5438, '2026-07-09T13:28:32.536Z', 77, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_625325dd43b540f8a98e305097017793', 'seed_usr_ryu_nexon', '2048', 5072, '2026-07-10T12:10:46.938Z', 154, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2daebac06bac4ef3aa48a943d354f771', 'seed_usr_ryu_nexon', '2048', 4156, '2026-07-10T12:15:56.785Z', 48, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2090db9cb6ec475dbe7a1f432e3a1314', 'seed_usr_ryu_nexon', '2048', 3946, '2026-07-11T11:40:30.075Z', 90, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f53a1b6e9fab431a8559dc924406b39e', 'seed_usr_ryu_nexon', '2048', 2542, '2026-07-11T11:48:19.716Z', 126, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_76078254f36c42a9b7c41307c0ff3d15', 'seed_usr_moon_ncsoft', 'sudoku', 960, '2026-06-15T08:15:56.801Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9c32a7618b5f4532aa8ebc65220ca3f6', 'seed_usr_moon_ncsoft', 'sudoku', 1116, '2026-06-15T08:25:20.267Z', 164, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1ac23343931e498b97fda9350eeb9164', 'seed_usr_moon_ncsoft', 'typing_game', 8798, '2026-06-15T08:31:21.800Z', 58, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_518fca708a3e41bf9e38a30962dbad8a', 'seed_usr_moon_ncsoft', 'typing_game', 7275, '2026-06-15T09:26:06.730Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bc38d29679654078bc306304ad27bb47', 'seed_usr_moon_ncsoft', 'typing_game', 8507, '2026-06-16T08:13:45.922Z', 109, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8ba5a7eb619e49d180a680f92abc12ed', 'seed_usr_moon_ncsoft', 'typing_game', 10812, '2026-06-16T08:25:43.077Z', 79, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a1fc7a654e094e1ba9246938b0bd7202', 'seed_usr_moon_ncsoft', 'sudoku', 750, '2026-06-16T08:25:53.662Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_72a7fbfa753a4a47bf5ac3fac6a6a36a', 'seed_usr_moon_ncsoft', 'typing_game', 9605, '2026-06-17T08:45:39.554Z', 78, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_021dd3d2244f400489e0d47ef7415ee0', 'seed_usr_moon_ncsoft', 'typing_game', 8569, '2026-06-17T08:50:03.336Z', 46, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_624935c2cd834e8ba9036432268092fe', 'seed_usr_moon_ncsoft', 'sudoku', 685, '2026-06-17T08:53:44.556Z', 127, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5b62bd55167f4e378323aba80ab75345', 'seed_usr_moon_ncsoft', 'typing_game', 6921, '2026-06-19T08:03:15.042Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6c9754d34ff145eab70f904f0f917fa4', 'seed_usr_moon_ncsoft', 'sudoku', 1115, '2026-06-19T08:12:54.154Z', 48, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5d074745a89f4847b9f6754a5511f76c', 'seed_usr_moon_ncsoft', 'sudoku', 496, '2026-06-22T07:17:13.558Z', 142, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2f6c9c56286b468593cb0da828b297b2', 'seed_usr_moon_ncsoft', 'typing_game', 5586, '2026-06-22T07:24:28.342Z', 54, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b0436ca7c0ad4fef810f48b32c8585c4', 'seed_usr_moon_ncsoft', 'sudoku', 1197, '2026-06-22T07:39:02.034Z', 228, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5fb66a4368ce46d89dba39c7a44754f8', 'seed_usr_moon_ncsoft', 'typing_game', 4947, '2026-06-23T07:33:53.101Z', 55, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3669ac2726494cf4a3359ee76bb56392', 'seed_usr_moon_ncsoft', 'typing_game', 5254, '2026-07-01T08:44:54.209Z', 91, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cb5dd5505b45441eb4670a7080cf26e5', 'seed_usr_moon_ncsoft', 'typing_game', 8444, '2026-07-01T08:48:32.347Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_40a992be1af6415f9313de750a95be49', 'seed_usr_moon_ncsoft', 'sudoku', 463, '2026-07-01T08:59:01.090Z', 226, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9ad09779d10b477e951ed5583d273e97', 'seed_usr_moon_ncsoft', 'typing_game', 3346, '2026-07-01T09:33:12.063Z', 101, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b92a13daa429467888234339d087bb96', 'seed_usr_moon_ncsoft', 'typing_game', 9018, '2026-07-03T08:32:13.693Z', 86, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b1810a9a6a884321885262c03f6f9332', 'seed_usr_moon_ncsoft', 'sudoku', 562, '2026-07-03T08:39:20.905Z', 247, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3e9e1ce23ba24aa08cb0426503e098fa', 'seed_usr_moon_ncsoft', 'typing_game', 6283, '2026-07-03T08:42:54.674Z', 92, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cbea77447e1c40dd834d7a6c3c16d5c3', 'seed_usr_moon_ncsoft', 'typing_game', 8397, '2026-07-06T08:26:39.281Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2bac353b5f1c476e80236c25ddc10bc3', 'seed_usr_moon_ncsoft', 'typing_game', 6280, '2026-07-06T08:32:04.420Z', 88, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_249e5e8d03ea4fb795d2115aaf95b56e', 'seed_usr_moon_ncsoft', 'typing_game', 6361, '2026-07-06T08:34:36.158Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9f424154eef3404f92dfd46430275eb7', 'seed_usr_moon_ncsoft', 'typing_game', 4866, '2026-07-06T09:53:45.566Z', 74, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_531930c4a0b54cc5bbe4e4cd0388e5f4', 'seed_usr_moon_ncsoft', 'sudoku', 1138, '2026-07-07T07:42:16.627Z', 135, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_89a9382d916346e290a83563e22f4829', 'seed_usr_moon_ncsoft', 'typing_game', 8155, '2026-07-07T07:50:35.151Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_db217caf59b84f4aac233aa09db18dcb', 'seed_usr_moon_ncsoft', 'typing_game', 6956, '2026-07-08T08:31:38.986Z', 90, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_73202211585c4ee6840b5c0cb99d4474', 'seed_usr_moon_ncsoft', 'sudoku', 1229, '2026-07-08T08:42:01.108Z', 149, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ba7cac2294d644bbafa42a8973e1900e', 'seed_usr_moon_ncsoft', 'sudoku', 630, '2026-07-08T08:43:42.072Z', 126, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7d86875fc1c4400d9e0f03c97dea57c6', 'seed_usr_moon_ncsoft', 'typing_game', 7075, '2026-07-09T07:27:47.906Z', 105, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b1e881f2d62a4786a898b0de860d550b', 'seed_usr_moon_ncsoft', 'sudoku', 1109, '2026-07-09T07:31:22.650Z', 210, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_37eae9ec72904c7ca4ea185d1777632b', 'seed_usr_moon_ncsoft', 'typing_game', 4724, '2026-07-09T07:51:29.267Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_627ee519613e422ebcf156ad337902c5', 'seed_usr_moon_ncsoft', 'sudoku', 619, '2026-07-09T08:50:10.920Z', 117, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4b0af9c9ec5a45f5aba55c9980670eae', 'seed_usr_moon_ncsoft', 'typing_game', 7690, '2026-07-10T08:34:31.046Z', 77, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d0257c1fe2ae4de2869b007ecc9b36f8', 'seed_usr_ko_cjenm', 'typing_game', 1253, '2026-06-17T00:42:40.234Z', 71, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ea042e3cf96f4bdb834afdbdda3f30b5', 'seed_usr_ko_cjenm', 'typing_game', 1547, '2026-06-17T00:52:08.651Z', 42, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fff16c034c034f29b69e2218381b949d', 'seed_usr_ko_cjenm', 'typing_game', 904, '2026-06-22T00:28:29.345Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_39622bf8dff144e0bb0d2634b0784c26', 'seed_usr_ko_cjenm', 'typing_game', 2758, '2026-06-24T00:34:05.648Z', 65, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a56964666b23475faf0481a26944ca08', 'seed_usr_ko_cjenm', 'typing_game', 801, '2026-06-30T00:31:11.880Z', 112, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5fba93b89ff7459597a722693454cdbd', 'seed_usr_ko_cjenm', 'typing_game', 2864, '2026-07-01T23:22:44.079Z', 119, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cb86e14b20f244f4a9f373d6ef66c95f', 'seed_usr_ko_cjenm', 'typing_game', 1581, '2026-07-01T23:27:16.407Z', 113, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_23b15c4a46fb4da093eb84dfe0af132f', 'seed_usr_ko_cjenm', 'typing_game', 1753, '2026-07-07T00:05:50.296Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_63aa955eff7640f5ae1857e89f447a81', 'seed_usr_ko_cjenm', 'typing_game', 1516, '2026-07-08T00:42:14.252Z', 65, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b73ab51508244aab94502412626823ce', 'seed_usr_yang_lotte', '2048', 7255, '2026-06-16T04:17:01.872Z', 54, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2bb1c996ebfe4f75a94020f5d9a7723e', 'seed_usr_yang_lotte', 'sudoku', 704, '2026-06-16T04:23:35.715Z', 116, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4af3fbcd9c144e0c82f3aa126e0e794b', 'seed_usr_yang_lotte', '2048', 3688, '2026-06-18T03:39:03.730Z', 35, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f2aa16e527544b16b7720cdbe277e340', 'seed_usr_yang_lotte', '2048', 6551, '2026-06-19T04:10:58.857Z', 89, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_22545b173c814f84ac4db913c8bdf4ae', 'seed_usr_yang_lotte', 'sudoku', 544, '2026-06-19T04:13:27.436Z', 285, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_072ca8cc622a4ae68578ff1d5c8d4f53', 'seed_usr_yang_lotte', 'sudoku', 394, '2026-06-22T03:17:20.483Z', 237, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9d85c06f555a4c7d8e8777e186d31f56', 'seed_usr_yang_lotte', 'sudoku', 607, '2026-06-22T03:20:35.271Z', 263, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_594a0ae113dc403dab3bbc1885064f23', 'seed_usr_yang_lotte', 'sudoku', 452, '2026-06-22T03:33:41.568Z', 133, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1301b09386be425a8f6c7d95aa8630e6', 'seed_usr_yang_lotte', 'sudoku', 404, '2026-06-24T03:39:37.871Z', 290, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5ca95130ddc2451980d6c05e77225cf6', 'seed_usr_yang_lotte', 'sudoku', 567, '2026-06-24T03:49:58.531Z', 105, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ceae04064ee14b88b467f8f5e442555b', 'seed_usr_yang_lotte', '2048', 5528, '2026-06-24T03:57:13.839Z', 120, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_67aad79edcb243399c933fbfc51d9f6a', 'seed_usr_yang_lotte', 'sudoku', 695, '2026-06-26T03:28:38.465Z', 91, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cdb304b8a98c428c8864713f3a1b9ef3', 'seed_usr_yang_lotte', 'sudoku', 417, '2026-06-26T03:36:53.877Z', 288, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3cc06929ec0f49378fe98cff50c1128c', 'seed_usr_yang_lotte', 'sudoku', 350, '2026-06-29T04:23:03.833Z', 109, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_88986c5a20c24f27a120452f75caa2f8', 'seed_usr_yang_lotte', '2048', 3078, '2026-06-29T04:30:45.796Z', 49, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0b85b5acc5f84719825d8f0b51b41213', 'seed_usr_yang_lotte', '2048', 10039, '2026-06-29T04:39:10.964Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_14cafa792d6b4adc889a59f838803cb2', 'seed_usr_yang_lotte', 'sudoku', 828, '2026-06-30T04:43:08.730Z', 139, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_afbad1a7ea9b4068a807e22660e5e4d5', 'seed_usr_yang_lotte', '2048', 6978, '2026-06-30T04:49:54.011Z', 124, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3e1854b97ea24ca58369623b1ff76c7e', 'seed_usr_yang_lotte', 'sudoku', 662, '2026-06-30T04:59:27.471Z', 284, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7c1d18e8e78c4536bf34c27898e9e5d0', 'seed_usr_yang_lotte', 'sudoku', 696, '2026-07-01T04:04:05.706Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_97eb184ffef74ab28d3871019847a6ec', 'seed_usr_yang_lotte', 'sudoku', 333, '2026-07-02T04:00:14.651Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4d51e721b08f46278b24584eba5addb3', 'seed_usr_yang_lotte', '2048', 6909, '2026-07-02T04:07:01.761Z', 169, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c67207bca6ba4930b7b5699330117c4d', 'seed_usr_yang_lotte', 'sudoku', 592, '2026-07-02T04:14:02.853Z', 123, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3738a5dc70374fd6bd1a39da9dc36ff2', 'seed_usr_yang_lotte', '2048', 9842, '2026-07-06T04:18:54.828Z', 154, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4787e048278443a3b90fcfb0c5a6cd7e', 'seed_usr_yang_lotte', 'sudoku', 592, '2026-07-06T04:26:27.946Z', 297, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_abb592893bc14f1b9aabfc7d6ed15e9b', 'seed_usr_yang_lotte', 'sudoku', 682, '2026-07-06T04:24:49.506Z', 297, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3bd11f11f1c7409c955541cbeb2daaba', 'seed_usr_yang_lotte', '2048', 10353, '2026-07-08T04:07:48.988Z', 125, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a372aa49506d4a4f96c6cf63e8fa19b7', 'seed_usr_yang_lotte', '2048', 6207, '2026-07-08T04:12:33.764Z', 168, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_68d93b8a426e429a86331121b2ec0bf3', 'seed_usr_bae_gs', 'sudoku', 352, '2026-06-14T22:19:05.966Z', 238, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_24e79f1173a14fd2a01ca7ad4ba38fd7', 'seed_usr_bae_gs', 'sudoku', 533, '2026-06-14T22:26:11.338Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ee6b44c6a210404e97018ac44d8cc8ec', 'seed_usr_bae_gs', 'sudoku', 457, '2026-06-17T14:32:42.987Z', 192, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ceb5be35c53f4c53986fea9f336338cd', 'seed_usr_bae_gs', 'sudoku', 263, '2026-06-17T14:39:00.500Z', 176, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9b598f23b12f4abeb17f58996503adae', 'seed_usr_bae_gs', 'sudoku', 310, '2026-06-17T14:42:13.319Z', 296, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_474f088efb294c6baad3cf1c299c3177', 'seed_usr_bae_gs', '2048', 4314, '2026-06-18T22:31:08.864Z', 136, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_54141970272f45b494e8f1ae9570e4b2', 'seed_usr_bae_gs', '2048', 7100, '2026-06-18T22:41:35.054Z', 62, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_960dff9f4a044a52ada782ca54b57579', 'seed_usr_bae_gs', 'sudoku', 337, '2026-06-20T22:33:40.541Z', 227, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_941fc9aebb4f41ad9e07363ad9c1e0fd', 'seed_usr_bae_gs', 'sudoku', 210, '2026-06-20T22:42:44.412Z', 105, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ea6ad6b0ea6e4eb18ac5016a7d364747', 'seed_usr_bae_gs', '2048', 4390, '2026-06-24T23:24:34.945Z', 89, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_377684a6e8f942b08ce27f37f00c8e5e', 'seed_usr_bae_gs', '2048', 1761, '2026-06-27T13:27:34.056Z', 54, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c822deda52964c1eab5c18bc464b2649', 'seed_usr_bae_gs', 'sudoku', 530, '2026-06-28T13:13:32.717Z', 49, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_aa3fa94dc75945c0bf65becee7d5d006', 'seed_usr_bae_gs', 'sudoku', 216, '2026-06-28T13:19:33.514Z', 133, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cd54a36fdbeb434392518f7e6006d187', 'seed_usr_bae_gs', 'sudoku', 290, '2026-07-04T22:10:05.182Z', 189, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_36669ea10d9f4a008643afe27766fbbe', 'seed_usr_bae_gs', '2048', 6758, '2026-07-12T13:41:19.297Z', 143, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_16c05a2e0c554448a5fc0199b5731635', 'seed_usr_bae_gs', '2048', 1908, '2026-07-12T13:52:54.902Z', 138, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_eda7446de17f4fb295b0cb5954b80fa4', 'seed_usr_hong_shinhan', 'sudoku', 1463, '2026-06-15T01:00:35.834Z', 221, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5a934789d8c54c10887783aef6d0142a', 'seed_usr_hong_shinhan', 'sudoku', 1402, '2026-06-17T02:26:24.420Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4f8150057e1b4017ac46aa6746927768', 'seed_usr_hong_shinhan', 'sudoku', 801, '2026-06-17T02:36:57.681Z', 241, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fe1f7821d7fd411187b03cbc6d529be4', 'seed_usr_hong_shinhan', 'sudoku', 1067, '2026-06-18T01:31:05.299Z', 141, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d48964835f1e4452bc0711fe0d30e20b', 'seed_usr_hong_shinhan', 'sudoku', 816, '2026-06-18T01:43:50.158Z', 63, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_59668c57247b4c4d9c1e74bcde08c06e', 'seed_usr_hong_shinhan', 'sudoku', 1074, '2026-06-19T01:01:38.097Z', 246, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ca50130cbaad4f33bd0c14eb6683f7e3', 'seed_usr_hong_shinhan', 'sudoku', 1390, '2026-06-19T01:06:53.480Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_48afec035f7941e6839c72ab9cb107db', 'seed_usr_hong_shinhan', 'sudoku', 869, '2026-06-19T01:21:09.179Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3de0f49483ee4443a82fb5c868366ee0', 'seed_usr_hong_shinhan', 'sudoku', 1007, '2026-06-19T02:28:19.954Z', 144, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_47f16a01328f430f895e681c11aa7501', 'seed_usr_hong_shinhan', 'sudoku', 1624, '2026-06-24T02:45:51.567Z', 194, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5ea117b4368f45a1a7743798d8f2c2cd', 'seed_usr_hong_shinhan', 'sudoku', 978, '2026-06-24T02:57:18.947Z', 79, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8085d1a9fa2a428890a0c2efefc7117f', 'seed_usr_hong_shinhan', 'sudoku', 1397, '2026-06-24T02:59:02.189Z', 121, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_57bc0d5fa16542d687c46439ec1ceaa6', 'seed_usr_hong_shinhan', 'sudoku', 982, '2026-06-25T01:07:31.581Z', 183, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b8eccbcbef8f49ec998f87939bd25046', 'seed_usr_hong_shinhan', 'sudoku', 984, '2026-06-26T02:15:41.400Z', 232, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_14c50dea6b464fa39087b719b0871cf6', 'seed_usr_hong_shinhan', 'sudoku', 1236, '2026-06-26T02:25:31.472Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ed802ad95e134e88a236c7aabfde4e95', 'seed_usr_hong_shinhan', 'sudoku', 1098, '2026-06-26T02:27:11.078Z', 299, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2c6a0565096c4927a789e61f05b73444', 'seed_usr_hong_shinhan', 'sudoku', 993, '2026-06-26T03:43:27.531Z', 300, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_aa75a7ad17a74fc8a7b35bfe93e2aa6f', 'seed_usr_hong_shinhan', 'sudoku', 951, '2026-06-29T01:18:28.106Z', 202, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e98006c3cb324c3984663740e3a2a981', 'seed_usr_hong_shinhan', 'sudoku', 712, '2026-06-29T01:21:44.080Z', 256, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6e2b9763907644ae90dc87969a18db32', 'seed_usr_hong_shinhan', 'sudoku', 923, '2026-06-29T01:38:02.063Z', 231, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f3ad3cf67671476583aced7866768f6c', 'seed_usr_hong_shinhan', 'sudoku', 1474, '2026-06-30T01:27:52.196Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ecd3a446dea241ff847485f8a84b2fc5', 'seed_usr_hong_shinhan', 'sudoku', 740, '2026-06-30T01:34:36.979Z', 141, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c4ce4c6840e34a3484177b68b5a0a39b', 'seed_usr_hong_shinhan', 'sudoku', 930, '2026-06-30T01:33:34.456Z', 279, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ef4abf4c7d4e4b888546a633ca1b1d95', 'seed_usr_hong_shinhan', 'sudoku', 1551, '2026-06-30T02:34:48.783Z', 240, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_548b9f4dc65e46d3b33ca71bd1af692e', 'seed_usr_hong_shinhan', 'sudoku', 1080, '2026-07-01T02:28:26.982Z', 262, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_26fcbfc6b0d6405cb98c5ac9205958b5', 'seed_usr_hong_shinhan', 'sudoku', 1559, '2026-07-01T02:36:21.927Z', 280, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b0e45c43948b44068d27341f819febde', 'seed_usr_hong_shinhan', 'sudoku', 1561, '2026-07-01T02:48:06.610Z', 188, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_63acd5583d4e40c4bc61611fae73d695', 'seed_usr_hong_shinhan', 'sudoku', 1277, '2026-07-03T02:23:20.665Z', 168, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_856909fab83b4970b74917881e606a22', 'seed_usr_hong_shinhan', 'sudoku', 1584, '2026-07-03T02:26:33.180Z', 145, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4a6082011dfa4c05881bd25747b48b26', 'seed_usr_hong_shinhan', 'sudoku', 1326, '2026-07-03T02:47:46.646Z', 214, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f5ff232ca3854fdc80b30fee2e24790f', 'seed_usr_hong_shinhan', 'sudoku', 1575, '2026-07-03T03:16:37.431Z', 262, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_253362763c1f4d57b31b0fd582324b02', 'seed_usr_hong_shinhan', 'sudoku', 755, '2026-07-06T02:01:59.137Z', 281, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9c1a555c79b84b4d9d41b526ccf62fe7', 'seed_usr_hong_shinhan', 'sudoku', 1124, '2026-07-06T02:07:05.670Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_150b01b07f5c4871b7192e3902d107f1', 'seed_usr_hong_shinhan', 'sudoku', 1213, '2026-07-06T02:07:17.776Z', 64, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_23ed22d4d91b4a4a81f2d7063a3fb7b9', 'seed_usr_hong_shinhan', 'sudoku', 956, '2026-07-07T02:26:53.947Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bdf76e7dec9c4a41ab29531fe96986f6', 'seed_usr_hong_shinhan', 'sudoku', 1448, '2026-07-07T02:33:33.494Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2d37dc6e9777444fbb0dee7cfe18938b', 'seed_usr_hong_shinhan', 'sudoku', 1208, '2026-07-07T02:40:54.694Z', 78, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c6d188a1db1a47fd85a13d581668dd0b', 'seed_usr_hong_shinhan', 'sudoku', 874, '2026-07-07T03:48:29.826Z', 278, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0ade7dfd9d694e70a670920339a67236', 'seed_usr_hong_shinhan', 'sudoku', 1169, '2026-07-08T02:00:27.838Z', 89, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4cbabda74f1344238a4d4ead66403114', 'seed_usr_hong_shinhan', 'sudoku', 1025, '2026-07-08T02:05:39.675Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6aad611438c74ce09939e13ed086a8a5', 'seed_usr_hong_shinhan', 'sudoku', 1600, '2026-07-08T02:12:01.865Z', 253, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_53bd9f93c25e48dc907d5ed847f52714', 'seed_usr_nam_posco', '2048', 13778, '2026-06-16T06:07:52.539Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_875ebabe382c41bbb2d14fadfd797cd0', 'seed_usr_nam_posco', 'typing_game', 8357, '2026-06-24T05:24:03.274Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_399dfce3d1654435be45ed5311caffc3', 'seed_usr_nam_posco', 'typing_game', 10899, '2026-06-26T06:35:02.874Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fecbb2d0e71447608da5ff6cd83f4160', 'seed_usr_nam_posco', '2048', 9116, '2026-06-29T06:29:33.174Z', 143, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_eb80a740cd8040a8857ba9640cbcd1d8', 'seed_usr_nam_posco', 'typing_game', 5574, '2026-06-29T06:39:14.304Z', 117, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_10649437f48043ae8b1c04fa8480aa2c', 'seed_usr_nam_posco', '2048', 11524, '2026-06-29T06:49:06.928Z', 136, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2d1bbaf3c71745eea91843901b98c12a', 'seed_usr_nam_posco', '2048', 5812, '2026-06-30T06:40:23.499Z', 168, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f57361ba6df34fd998b4f185725be45d', 'seed_usr_nam_posco', '2048', 8368, '2026-07-02T06:26:56.140Z', 157, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b85b83cbe41c401a8ce7a5d053f51012', 'seed_usr_nam_posco', 'typing_game', 8356, '2026-07-03T06:00:40.402Z', 61, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_68f4d89854fb44d8bccbb9ed317a11de', 'seed_usr_nam_posco', 'typing_game', 10157, '2026-07-06T06:36:30.180Z', 58, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9ef4f75c8bca4f17801785f8fd26a639', 'seed_usr_nam_posco', '2048', 12953, '2026-07-06T06:41:06.035Z', 167, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_759107514d9348ff8a1f2a9c795e6fcd', 'seed_usr_nam_posco', 'typing_game', 5537, '2026-07-06T06:44:55.414Z', 47, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6769c13cf1854d9d84061a1de70b40de', 'seed_usr_nam_posco', 'typing_game', 4103, '2026-07-07T06:14:35.518Z', 69, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6bcba770d1ed4bd880b5b3379e2c64a1', 'seed_usr_nam_posco', 'typing_game', 6818, '2026-07-07T06:25:56.184Z', 88, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0f8bbc5541e440c4b78dd1bed5d64c82', 'seed_usr_nam_posco', 'typing_game', 9405, '2026-07-07T06:20:49.758Z', 81, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f6f74443e3c24c25bebfdc9ec38e7eca', 'npc_usr_hr_bot', 'typing_game', 5202, '2026-06-15T08:36:00.136Z', 48, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6d9d2d7780e9451d8320b57b837433c4', 'npc_usr_hr_bot', 'typing_game', 5623, '2026-06-15T08:44:49.030Z', 51, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_fbec3d8884704bb4b2cd695306af8b71', 'npc_usr_hr_bot', '2048', 4042, '2026-06-19T04:31:59.539Z', 89, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_160ad5f99f594b379f1bcf0a6a4adbce', 'npc_usr_hr_bot', 'typing_game', 4680, '2026-06-22T00:11:45.661Z', 42, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e0d3ce1abc2b449ab9c3c890f73c4387', 'npc_usr_hr_bot', 'typing_game', 4708, '2026-06-22T00:19:55.231Z', 65, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a04a585f64d44cfd94c6d4db18da67e0', 'npc_usr_hr_bot', '2048', 7407, '2026-06-24T04:35:13.887Z', 35, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5c7223936d04424fb1dd4ce72e1f526b', 'npc_usr_hr_bot', 'typing_game', 7188, '2026-06-24T04:41:29.719Z', 76, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6a6117adf29c4cb1a8f9621936846694', 'npc_usr_hr_bot', 'typing_game', 5780, '2026-06-24T04:57:59.450Z', 117, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_213545d8f2e74f7aac17943d7c8957a0', 'npc_usr_hr_bot', 'typing_game', 4886, '2026-06-24T05:43:24.414Z', 106, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0043107a637a46e9b599de6c545f4aea', 'npc_usr_hr_bot', 'typing_game', 6284, '2026-06-26T04:21:12.902Z', 103, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_299b0c90e8f8459aa228d39ee8f9a01f', 'npc_usr_hr_bot', 'typing_game', 2010, '2026-06-26T04:32:15.041Z', 42, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6ac9791e921e43d78c460b14c0a66876', 'npc_usr_hr_bot', 'typing_game', 6814, '2026-06-26T04:35:23.258Z', 86, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f95eadf6227b4849bf78cee17a46d9c5', 'npc_usr_hr_bot', 'typing_game', 4633, '2026-06-29T00:27:21.593Z', 62, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0b745d27a17f43a6b932eb820762da29', 'npc_usr_hr_bot', 'typing_game', 5903, '2026-06-29T00:31:27.103Z', 55, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_05c3d0cdc78c458fa1a0657feadf647a', 'npc_usr_hr_bot', 'typing_game', 2705, '2026-07-01T08:36:40.726Z', 43, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f2728d14addc44429c7cebb331f6a33c', 'npc_usr_hr_bot', 'typing_game', 1871, '2026-07-03T00:11:13.365Z', 44, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c6c7a233edf14da4a965f44c486adbc7', 'npc_usr_hr_bot', 'typing_game', 4940, '2026-07-06T00:39:15.774Z', 82, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ba4e2ccb32a149f4a1f3750ef4f73e36', 'npc_usr_hr_bot', 'typing_game', 873, '2026-07-06T00:50:30.241Z', 55, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ba32fa4b4a6d408ca31f4ee3083f650b', 'npc_usr_hr_bot', '2048', 8911, '2026-07-06T00:51:27.840Z', 90, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e923f1e306014de8a7dc3f7a2f5b5c63', 'npc_usr_hr_bot', '2048', 3449, '2026-07-06T01:25:13.472Z', 110, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a834d0da4da945f38f01b07a2e4e1282', 'npc_usr_hr_bot', 'typing_game', 2935, '2026-07-08T08:13:00.861Z', 91, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5e1ff91dca9046a6b3c6fe8124600a75', 'npc_usr_hr_bot', 'typing_game', 5753, '2026-07-10T08:33:41.828Z', 83, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7158b784b72e4d5a9f9fdc0ff283f0b7', 'npc_usr_hr_bot', '2048', 9268, '2026-07-10T08:40:57.174Z', 99, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_61483081d43946cab8fbe0d7ab5e675f', 'npc_usr_hr_bot', 'typing_game', 1780, '2026-07-10T08:57:22.504Z', 70, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5733968695324e9189bed641207ea651', 'npc_usr_hr_bot', 'typing_game', 1893, '2026-07-10T09:27:22.863Z', 85, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_26c7c50d6eca4bbe9b3b3fd556c4b256', 'npc_usr_sales_bot', '2048', 5408, '2026-06-15T06:42:27.421Z', 34, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d2030951790341f4a2c9dc547db160bb', 'npc_usr_sales_bot', 'sudoku', 361, '2026-06-15T06:45:14.389Z', 275, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1fa92b6e671c4772b847868d4f30f1d0', 'npc_usr_sales_bot', '2048', 7192, '2026-06-15T06:48:46.851Z', 71, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_39a936758fc74fb6882561b21ad35f50', 'npc_usr_sales_bot', '2048', 2014, '2026-06-18T06:33:07.218Z', 41, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_8daa343e6b084959b2fdee1b0b5723a2', 'npc_usr_sales_bot', '2048', 5631, '2026-06-18T06:42:23.871Z', 30, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6a484839b0cc41d295de6c6d6eb25d15', 'npc_usr_sales_bot', '2048', 8911, '2026-06-18T06:43:18.851Z', 45, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a6732f075c4249ee9a4cef4eebeb1e91', 'npc_usr_sales_bot', '2048', 1423, '2026-06-21T06:23:51.203Z', 103, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6242c31ab37d458b9ec297fd1a978f7b', 'npc_usr_sales_bot', 'sudoku', 285, '2026-06-21T06:35:53.080Z', 251, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_adf5bed4d9e143b9bacb0c45580ebb56', 'npc_usr_sales_bot', 'sudoku', 430, '2026-06-21T06:45:48.026Z', 259, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_66ea81488e9845f0871f5ecfda0c711d', 'npc_usr_sales_bot', 'sudoku', 328, '2026-06-24T06:45:49.344Z', 126, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1865e5a855b344b1a5c7295bf0f712e6', 'npc_usr_sales_bot', 'sudoku', 547, '2026-06-24T06:54:45.524Z', 123, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b2090bfbc02b49ac8eda6bdabfaa7e99', 'npc_usr_sales_bot', 'sudoku', 615, '2026-06-24T06:53:12.401Z', 298, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d4c92d1ede5641909026966f3d83bddc', 'npc_usr_sales_bot', 'sudoku', 145, '2026-06-27T06:07:14.720Z', 79, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_26c68445642b455dac09e5282275c266', 'npc_usr_sales_bot', '2048', 6578, '2026-06-27T06:12:20.047Z', 51, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e6a41c8a41f14d4ab063379e60d280c3', 'npc_usr_sales_bot', '2048', 4288, '2026-06-27T06:15:44.419Z', 42, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1fc297c37cdf421d9a7f2cb811bad6fa', 'npc_usr_sales_bot', '2048', 2606, '2026-06-30T06:21:08.809Z', 173, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_3f0ad3ffd1534b0fabc09fc9b0ebfb47', 'npc_usr_sales_bot', '2048', 9018, '2026-06-30T06:29:31.598Z', 95, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a778534c8a9041738b70a6c3544ae5e7', 'npc_usr_sales_bot', 'sudoku', 405, '2026-06-30T06:43:15.014Z', 188, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_3d6c23ff8dd14b3fb0e5ee0ab1a41223', 'npc_usr_sales_bot', 'sudoku', 612, '2026-07-03T06:35:33.831Z', 155, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_47221894259e4393a91190e66e1fd4a0', 'npc_usr_sales_bot', 'sudoku', 355, '2026-07-03T06:38:54.371Z', 193, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ed85bd2b0815481e9a9112b5ba6e4f5b', 'npc_usr_sales_bot', 'sudoku', 121, '2026-07-03T06:45:10.271Z', 144, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_71d8de6c332f4aa0b89037f904be747b', 'npc_usr_sales_bot', 'sudoku', 171, '2026-07-06T06:24:15.735Z', 282, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_aac55a3bcbdc481e999193d0035e7975', 'npc_usr_sales_bot', 'sudoku', 392, '2026-07-06T06:36:36.739Z', 294, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_be1649e2799d4910beb929f0b5b1f6ed', 'npc_usr_sales_bot', 'sudoku', 567, '2026-07-06T06:34:53.497Z', 293, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c936cef7822d4b17bbf06e9417bd1c6d', 'npc_usr_sales_bot', 'sudoku', 733, '2026-07-09T06:30:47.689Z', 290, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_93d5ec000c5c4b69833768a74a56d769', 'npc_usr_sales_bot', 'sudoku', 445, '2026-07-09T06:39:35.064Z', 114, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_41db8db164024937ab42da2a9543b920', 'npc_usr_sales_bot', 'sudoku', 554, '2026-07-09T06:52:53.633Z', 212, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_83893041163b4cf496241eaf376fad61', 'npc_usr_sales_bot', 'sudoku', 850, '2026-07-12T06:20:24.509Z', 66, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0f632ae4de40470a87b9e6d54cc9d8e7', 'npc_usr_sales_bot', 'sudoku', 287, '2026-07-12T06:29:19.189Z', 227, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_db170c08aed84eedbf3beea86b7be6ae', 'npc_usr_sales_bot', '2048', 2833, '2026-07-12T06:34:04.788Z', 144, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ecdca235540e4e1c8cdd52696ed5a765', 'npc_usr_night_owl', 'sudoku', 110, '2026-06-15T16:39:01.819Z', 55, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_981a8846ffb94fc9bef96e990dd59a9e', 'npc_usr_night_owl', 'sudoku', 687, '2026-06-15T16:50:22.973Z', 133, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b2f7a027112f499ba3a0e3d392d2cb92', 'npc_usr_night_owl', 'typing_game', 1663, '2026-06-22T16:23:41.283Z', 51, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_52c301214a294e5bb3643ad3a5e29706', 'npc_usr_night_owl', 'sudoku', 576, '2026-06-24T14:43:41.560Z', 159, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1d4453401dc24da4b378d3ef9c1d6d6e', 'npc_usr_night_owl', 'sudoku', 841, '2026-06-24T14:47:35.638Z', 149, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_bd79560778ab46828663c4d4db9657aa', 'npc_usr_night_owl', 'typing_game', 3260, '2026-06-24T16:14:46.656Z', 64, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f464f826c62e42d9b48fed561b2bdd5b', 'npc_usr_night_owl', 'typing_game', 6643, '2026-06-29T16:03:53.756Z', 115, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_21e2b8709504447899786429e7e13c0d', 'npc_usr_night_owl', 'sudoku', 537, '2026-06-29T16:15:26.815Z', 45, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_3f5a6219255e4484991ec29487c26eef', 'npc_usr_night_owl', 'typing_game', 6962, '2026-07-02T14:22:32.555Z', 79, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_265fd0ef7b6e4b23a95b2c1108dd471f', 'npc_usr_night_owl', 'typing_game', 6655, '2026-07-02T14:28:23.303Z', 104, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5c2a82315b1c4956bb469cf69ef16564', 'npc_usr_night_owl', 'typing_game', 3483, '2026-07-03T14:16:59.769Z', 100, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5990ed88f8c941469ee801bfdf137f77', 'npc_usr_night_owl', 'typing_game', 6748, '2026-07-05T16:15:12.699Z', 99, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b10dbaee37c941d58b40f25c7ac5af7e', 'npc_usr_night_owl', 'typing_game', 3231, '2026-07-06T16:41:56.350Z', 90, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_65971ee6cad4440cb570b788420a07a3', 'npc_usr_night_owl', 'typing_game', 4502, '2026-07-08T16:18:05.982Z', 107, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ef2426b1b66e4f83a3a8fa00b1061036', 'npc_usr_night_owl', 'typing_game', 2690, '2026-07-08T16:23:59.783Z', 54, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9042769171244e219e5cb09c2833b061', 'npc_usr_intern_bot', 'sudoku', 576, '2026-06-19T01:27:27.959Z', 86, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e048bab106a34845807dd0f9c0655055', 'npc_usr_intern_bot', 'sudoku', 329, '2026-06-19T01:38:22.262Z', 112, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_12e96fa75c5a470bbe01ecef896b518c', 'npc_usr_intern_bot', '2048', 4471, '2026-06-19T01:37:11.691Z', 102, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e2aca383af1a47dfbd840df16fb95d9a', 'npc_usr_intern_bot', '2048', 9514, '2026-06-19T02:38:32.684Z', 73, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6219bc2d7222470eae2bb5b39b779074', 'npc_usr_intern_bot', '2048', 4597, '2026-06-22T07:41:30.270Z', 138, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d818c2960ffa4039b006a0daf8c7cde2', 'npc_usr_intern_bot', 'sudoku', 525, '2026-06-22T07:45:15.540Z', 159, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f95d4a80492249b5acd0815f5b56261e', 'npc_usr_intern_bot', '2048', 7534, '2026-06-24T07:12:40.512Z', 149, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f554b1ae115347908ff6f4e094495a76', 'npc_usr_intern_bot', '2048', 9902, '2026-06-24T07:23:36.686Z', 57, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_868962fef5d14bf5b371a0815424ffb7', 'npc_usr_intern_bot', '2048', 9975, '2026-06-24T07:32:16.428Z', 144, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ce63cfeab74142a0be7ccc7e47bcc148', 'npc_usr_intern_bot', 'sudoku', 184, '2026-06-26T07:41:24.225Z', 134, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_684e6ddb46ea49009189f7d71458d81d', 'npc_usr_intern_bot', '2048', 8265, '2026-06-26T07:53:23.122Z', 173, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_58b7ba57f066430ba3b405b462eea310', 'npc_usr_intern_bot', '2048', 7339, '2026-06-26T07:57:53.727Z', 83, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a22f3fd197d44d749a4cf85089d9ff12', 'npc_usr_intern_bot', 'sudoku', 310, '2026-06-29T01:26:33.698Z', 191, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1755c2e2593344d3a7e2d69adecbc7b8', 'npc_usr_intern_bot', '2048', 2839, '2026-06-29T01:36:27.045Z', 149, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b65ff1fa2ef1466fae03226f0eff5586', 'npc_usr_intern_bot', 'sudoku', 493, '2026-06-29T01:50:47.906Z', 294, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_05f9d533a0e241c78d3d3d6c3184a610', 'npc_usr_intern_bot', '2048', 5738, '2026-06-29T02:34:09.841Z', 45, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7b71a2f9130441758dc9f2441d39839a', 'npc_usr_intern_bot', 'sudoku', 673, '2026-07-01T01:12:48.006Z', 258, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_60c85658e1e545a89c1c34059b3cc11e', 'npc_usr_intern_bot', '2048', 9348, '2026-07-03T07:19:23.368Z', 144, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_cebc8365d72a4d2a93dda12d6d2ef416', 'npc_usr_intern_bot', 'sudoku', 273, '2026-07-03T07:23:15.598Z', 210, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5f86996911714a4391998a9336b359bf', 'npc_usr_intern_bot', 'sudoku', 348, '2026-07-03T07:25:05.395Z', 53, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_125c496158aa4458ab0fb8f4eaf5e5ba', 'npc_usr_intern_bot', 'sudoku', 173, '2026-07-08T01:18:05.922Z', 178, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c8d306944c874a62a45a09e4b8955507', 'npc_usr_intern_bot', '2048', 7273, '2026-07-08T01:30:17.236Z', 95, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5aefac4ca61b492eba4c7abda3b609e1', 'npc_usr_intern_bot', '2048', 1501, '2026-07-10T01:39:18.987Z', 149, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b66d5c3b5354493cab49d0bf81c0e7b2', 'npc_usr_intern_bot', '2048', 4979, '2026-07-10T01:46:57.595Z', 91, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_55af1191f66d4028b064cc64784786b2', 'npc_usr_intern_bot', '2048', 1588, '2026-07-10T01:57:23.328Z', 166, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_02401068a3af4c30b1f382f872035bb3', 'npc_usr_cs_bot', 'typing_game', 3914, '2026-06-15T05:40:21.811Z', 115, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_44feffa38be9465880cb4fbe31706a07', 'npc_usr_cs_bot', '2048', 3199, '2026-06-15T05:43:48.667Z', 158, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_276649d4a241463aa0157951981ac70d', 'npc_usr_cs_bot', '2048', 4115, '2026-06-15T05:59:37.647Z', 151, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d4b4faf30fee4e8784f6d79a2b1785d3', 'npc_usr_cs_bot', '2048', 8851, '2026-06-18T02:33:29.955Z', 83, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5bc755e244e742fda055c13181980a77', 'npc_usr_cs_bot', '2048', 1624, '2026-06-18T02:36:18.523Z', 161, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_38463c385a7643b0b8a9ec1c14bb866a', 'npc_usr_cs_bot', '2048', 2540, '2026-06-18T02:47:29.883Z', 144, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_04c949b1380c4c3c8dbfe040ff12bd5b', 'npc_usr_cs_bot', '2048', 8891, '2026-06-21T02:08:54.224Z', 149, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_625442609cb1483287fdd904086887fb', 'npc_usr_cs_bot', 'typing_game', 4287, '2026-06-21T02:19:25.261Z', 50, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_dcb7c7c4658f4e5ebd29fc7d189b54d1', 'npc_usr_cs_bot', 'typing_game', 1588, '2026-06-21T02:28:58.564Z', 58, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_de476474b3194b9988b8f176f86e8726', 'npc_usr_cs_bot', '2048', 5940, '2026-06-24T05:10:03.238Z', 136, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_747a05d84f024666888e6586ca20a9de', 'npc_usr_cs_bot', '2048', 3377, '2026-06-24T05:14:44.942Z', 125, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c17a8731ffc7413ba154c9107553e5ae', 'npc_usr_cs_bot', 'typing_game', 7005, '2026-06-24T05:16:37.554Z', 65, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_42b8c3b8d73d47a3a2795bab1a8336b8', 'npc_usr_cs_bot', '2048', 1244, '2026-06-27T05:38:50.434Z', 40, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_bffeced0f334405b9c2094dedcabb5b4', 'npc_usr_cs_bot', 'typing_game', 1245, '2026-06-27T05:47:08.181Z', 69, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_79b6d61a7461419f957c01d56ef826b4', 'npc_usr_cs_bot', 'typing_game', 7065, '2026-06-27T05:50:43.653Z', 94, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e214cd63f4fe46d196d2d1aff4219e1a', 'npc_usr_cs_bot', '2048', 5635, '2026-06-30T02:05:47.002Z', 58, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_76723cac5b5349379cf0fc536f150741', 'npc_usr_cs_bot', '2048', 7667, '2026-06-30T02:08:46.623Z', 56, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_88bae840b9c34a8fbb8c2478790af828', 'npc_usr_cs_bot', 'typing_game', 3241, '2026-06-30T02:11:47.642Z', 88, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_02bc469db51e48ebb276d369c4351e79', 'npc_usr_cs_bot', 'typing_game', 1574, '2026-07-03T02:26:59.877Z', 90, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7ef0496a5dd7499099fcdd142b71ace9', 'npc_usr_cs_bot', '2048', 3387, '2026-07-03T02:34:13.343Z', 85, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b382645ecbf84a51860150c08ce039d3', 'npc_usr_cs_bot', 'typing_game', 6207, '2026-07-03T02:38:04.451Z', 52, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1a69cff37d4e4ec8ba42289458b106ed', 'npc_usr_cs_bot', '2048', 3214, '2026-07-06T05:16:16.282Z', 43, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d2d92815d9dd4c3c8e35598b54064db6', 'npc_usr_cs_bot', 'typing_game', 4723, '2026-07-06T05:24:43.857Z', 120, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_8730b430b2644d1c9f052d3c21a9a5a1', 'npc_usr_cs_bot', '2048', 8642, '2026-07-06T05:38:00.132Z', 80, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ee999a391c7141b594dbe5d63a9a8522', 'npc_usr_cs_bot', '2048', 7387, '2026-07-09T05:11:26.717Z', 138, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_640601adbb524d6daaf13d02da558be8', 'npc_usr_cs_bot', '2048', 1319, '2026-07-09T05:22:44.255Z', 46, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d78931dda1e64a5091d077b44bdab07a', 'npc_usr_cs_bot', 'typing_game', 6641, '2026-07-09T05:17:07.712Z', 100, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_4d1dd7ebee3b401687088a5a33165131', 'npc_usr_cs_bot', 'typing_game', 6340, '2026-07-12T05:14:19.068Z', 114, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d6c86b5016d94032941d755f0efeb01c', 'npc_usr_cs_bot', '2048', 1376, '2026-07-12T05:21:34.800Z', 33, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_06c6a0e7106f4605868d48216b269d2d', 'npc_usr_cs_bot', '2048', 9697, '2026-07-12T05:22:58.718Z', 83, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ecf98106fff64bf791d61878f92416cc', 'npc_usr_weekend_bot', 'sudoku', 801, '2026-06-15T06:27:11.492Z', 268, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_87fcdf01710b48a8b9fc1761b7b29eba', 'npc_usr_weekend_bot', 'sudoku', 756, '2026-06-15T06:31:48.437Z', 158, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6c70ae4cd6d043adaf10f5a3b7afc7cd', 'npc_usr_weekend_bot', '2048', 6460, '2026-06-17T04:05:30.325Z', 87, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7cbebd87b8b148ae8563ee8514e58474', 'npc_usr_weekend_bot', 'sudoku', 250, '2026-06-17T04:17:37.652Z', 56, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1b993307858b43af8a5780f3814644c4', 'npc_usr_weekend_bot', '2048', 4656, '2026-06-18T04:12:21.936Z', 51, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_23594c0e44c9442dac7c2c3fdcbd7d76', 'npc_usr_weekend_bot', 'sudoku', 558, '2026-06-23T06:36:30.526Z', 127, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_58b4d03acb0e425ba4fc78acdcc103c5', 'npc_usr_weekend_bot', 'sudoku', 858, '2026-06-23T06:43:44.010Z', 253, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a7749bd69f1c4e948d115ce825320210', 'npc_usr_weekend_bot', 'sudoku', 330, '2026-06-29T06:41:33.047Z', 175, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_69c0d95fbef94dffa7811fc753462ae9', 'npc_usr_weekend_bot', '2048', 7287, '2026-07-03T06:04:47.526Z', 77, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_cfe19e34e9894b74b6dc9e689ebf26b1', 'npc_usr_weekend_bot', 'sudoku', 308, '2026-07-07T06:40:38.269Z', 201, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ada2d4b33d0546ca9ee67f18c174fb5d', 'npc_usr_weekend_bot', '2048', 1736, '2026-07-07T06:43:52.697Z', 145, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_79fc2b74217a4e9cb5af8d210ecba2f0', 'npc_usr_weekend_bot', 'sudoku', 790, '2026-07-08T06:18:35.863Z', 128, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9682ff56098841d7b790de2668cb8ea0', 'npc_usr_weekend_bot', 'sudoku', 845, '2026-07-08T06:21:18.949Z', 290, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_968c8466dc484ae8a03648e31174601a', 'npc_usr_weekend_bot', 'sudoku', 440, '2026-07-09T04:33:34.035Z', 112, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_05d4dc2630fc469bbab875ba364c6842', 'npc_usr_weekend_bot', 'sudoku', 241, '2026-07-10T06:33:45.560Z', 54, '{"seed":true,"source":"npc"}');

-- Step 5: User points (approximated from total scores / 10)
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_kim_daeri', 1638, 1638, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_park_staff', 4948, 4948, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_lee_manager', 4226, 4226, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_choi_junior', 1668, 1668, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_jung_intern', 874, 874, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_yoon_mgr', 2109, 2109, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_oh_lead', 2242, 2242, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_qa_bot', 2186, 2186, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_kim_daeri', 2549, 2549, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_todaki', 3730, 3730, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_song_lg', 1782, 1782, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_han_sk', 1542, 1542, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_baek_coupang', 1008, 1008, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_woo_baemin', 4225, 4225, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_shin_toss', 3781, 3781, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_ahn_carrot', 2278, 2278, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_jang_krafton', 827, 827, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_ryu_nexon', 4869, 4869, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_moon_ncsoft', 2927, 2927, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_ko_cjenm', 4918, 4918, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_yang_lotte', 3751, 3751, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_bae_gs', 1405, 1405, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_hong_shinhan', 4162, 4162, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_nam_posco', 2429, 2429, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_hr_bot', 2444, 2444, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_sales_bot', 2127, 2127, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_night_owl', 1971, 1971, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_intern_bot', 4216, 4216, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_cs_bot', 3760, 3760, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_weekend_bot', 3279, 3279, 0, '2026-07-12T14:58:19.494Z', '2026-07-12T14:58:19.494Z');

-- Step 6: Company tags for seed companies
INSERT OR IGNORE INTO companies (id, name, created_at)
VALUES ('ctag_0f6e10f42fe14440bc54a668312cd4bc', 'Refresheet Office', '2026-07-12T14:58:19.494Z');
INSERT OR IGNORE INTO companies (id, name, created_at)
VALUES ('ctag_9924d94024db4179b803a2f73e3da21f',  'Refresheet Lab',    '2026-07-12T14:58:19.494Z');

-- Summary: 30 virtual users, ~798 game_score rows
-- Seed accounts (source=seed): 21
-- NPC accounts  (source=npc):  9
-- To verify isolation:
--   SELECT source, is_virtual, COUNT(*) FROM users GROUP BY source, is_virtual;
--   SELECT u.source, COUNT(gs.id) AS plays FROM game_scores gs JOIN users u USING(user_id) GROUP BY u.source;