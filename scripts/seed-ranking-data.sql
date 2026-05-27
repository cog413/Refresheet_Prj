-- ============================================================
-- Refresheet seed ranking data
-- Generated: 2026-05-27T18:20:30.625Z
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
DELETE FROM point_wallets WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);
DELETE FROM avatars       WHERE user_id IN (SELECT user_id FROM users WHERE is_virtual = 1);
DELETE FROM users         WHERE is_virtual = 1;

-- Step 2: Seed / NPC user accounts
-- All accounts: is_virtual=1, google_sub=NULL, onboarding_done=1
-- Emails: @seed.refresheet.local — non-routable, never sent
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_kim_daeri', 'seed_kim_daeri@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Office', '09:00', '18:00', 1, '김대리', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_park_staff', 'seed_park_staff@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Office', '09:00', '18:00', 1, '박사원', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_lee_manager', 'seed_lee_manager@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Office', '08:30', '18:00', 1, '이과장', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_choi_junior', 'seed_choi_junior@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Office', '09:00', '18:30', 1, '최주임', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_jung_intern', 'seed_jung_intern@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Office', '09:00', '18:00', 1, '정인턴', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_yoon_mgr', 'seed_yoon_mgr@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Office', '08:00', '18:00', 1, '윤매니저', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('seed_usr_oh_lead', 'seed_oh_lead@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Office', '08:00', '17:30', 1, '오팀장', 1, 'seed', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_qa_bot', 'npc_qa_bot@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Lab', '00:00', '23:59', 1, 'QA_BOT', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_kim_daeri', 'npc_kim_daeri@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Lab', '09:00', '18:00', 1, '김대리NPC', 1, 'npc', 1);
INSERT OR IGNORE INTO users (user_id, email, google_sub, created_at, updated_at, company, commute_start, commute_end, onboarding_done, employee_name, is_active, source, is_virtual)
VALUES ('npc_usr_todaki', 'npc_todaki@seed.refresheet.local', NULL, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z', 'Refresheet Lab', '09:00', '18:00', 1, '토닥이NPC', 1, 'npc', 1);

-- Step 3: Avatar rows (minimal, required for /api/me parity)
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_kim_daeri', '김대리', 'type_a', 'mong', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_park_staff', '박사원', 'type_a', 'rabbit', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_lee_manager', '이과장', 'type_a', 'mong', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_choi_junior', '최주임', 'type_a', 'rabbit', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_jung_intern', '정인턴', 'type_a', 'rabbit', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_yoon_mgr', '윤매니저', 'type_a', 'mong', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('seed_usr_oh_lead', '오팀장', 'type_a', 'mong', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_qa_bot', 'QA_BOT', 'type_a', 'mong', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_kim_daeri', '김대리NPC', 'type_a', 'mong', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO avatars (user_id, nickname, character_type, character_key, created_at, updated_at)
VALUES ('npc_usr_todaki', '토닥이NPC', 'type_a', 'mong', '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');

-- Step 4: Game score history (past 28 days, max 3/hour, max 6/day)
-- All score IDs prefixed seed_gsc_ / npc_gsc_ for easy identification
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_bc0450dcdcda44d88d09a59bf205da00', 'seed_usr_kim_daeri', '2048', 3400, '2026-04-30T04:13:03.938Z', 149, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8ff8f1b545524ef1855fae2be492d872', 'seed_usr_kim_daeri', '2048', 2095, '2026-05-01T03:42:52.156Z', 83, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f734b062b831462a963450cabeef99f6', 'seed_usr_kim_daeri', '2048', 3765, '2026-05-01T03:53:06.454Z', 126, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f28171de07674ea791b9238315afa791', 'seed_usr_kim_daeri', 'sudoku', 3902, '2026-05-01T03:56:01.478Z', 276, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_29893dd6251d449cabefb2e4f8c15a2d', 'seed_usr_kim_daeri', '2048', 2544, '2026-05-01T04:56:27.116Z', 78, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d1c984ea32da438fa56e9b943af798e9', 'seed_usr_kim_daeri', '2048', 7716, '2026-05-04T04:34:42.441Z', 117, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_72531b41653e4cb189bea93f775bce3d', 'seed_usr_kim_daeri', 'sudoku', 4528, '2026-05-04T04:41:33.172Z', 246, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8039f35c34ac4f0bad2cffe11ab9fdfe', 'seed_usr_kim_daeri', '2048', 2682, '2026-05-04T04:56:59.334Z', 69, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4611c69e709a4d7f8c5e365463540209', 'seed_usr_kim_daeri', '2048', 2985, '2026-05-05T04:17:30.579Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c920c1e0435b4e379d99988f606bfb0b', 'seed_usr_kim_daeri', 'sudoku', 3094, '2026-05-05T04:28:57.902Z', 188, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0e21fec9e169421791ea30333b04504f', 'seed_usr_kim_daeri', '2048', 5747, '2026-05-05T04:41:15.805Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6a48fc1563a04b4c847fb67dcf522cff', 'seed_usr_kim_daeri', 'sudoku', 3399, '2026-05-08T03:28:01.896Z', 68, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0770dc6bbbd04c0089f288de49b8f1c1', 'seed_usr_kim_daeri', 'sudoku', 1881, '2026-05-08T03:32:10.410Z', 232, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e1ed6489b9e64516b6b09e236c28afa9', 'seed_usr_kim_daeri', '2048', 2061, '2026-05-12T03:13:00.300Z', 114, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0735e61a6bd243eda3e09df9384a8317', 'seed_usr_kim_daeri', 'sudoku', 3814, '2026-05-12T03:21:07.813Z', 298, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_540288211ad04a10bb8aefa67c96c8f0', 'seed_usr_kim_daeri', '2048', 8518, '2026-05-12T03:29:55.644Z', 168, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_126156b351b94e89b860f763a636a8ac', 'seed_usr_kim_daeri', 'sudoku', 3777, '2026-05-14T03:06:23.815Z', 102, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7afd7ccf41bb4286a2a672e5235c6f72', 'seed_usr_kim_daeri', '2048', 4896, '2026-05-14T03:14:55.558Z', 101, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3088a4bc99414e0994e7201a8ef11abb', 'seed_usr_kim_daeri', '2048', 2747, '2026-05-14T03:18:23.824Z', 107, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_77647f9bb2ea411dbbf17fb50776b065', 'seed_usr_kim_daeri', 'sudoku', 3629, '2026-05-14T04:47:06.649Z', 124, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4a1cea5b797e4b43bd7734dcf8c0727c', 'seed_usr_kim_daeri', '2048', 3577, '2026-05-15T03:44:49.429Z', 74, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0ad9111d4ac74855a07e2f436d77d5c6', 'seed_usr_kim_daeri', '2048', 6936, '2026-05-18T04:25:14.142Z', 140, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d3fba126f2b8466db7a0a3518ec2edce', 'seed_usr_kim_daeri', '2048', 9088, '2026-05-18T04:33:36.060Z', 80, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_e330eb31ee9c4ec2bbac595bc27d00f8', 'seed_usr_kim_daeri', '2048', 8416, '2026-05-19T04:02:07.446Z', 63, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d22ccb18eb1f49ac818048db7450ef03', 'seed_usr_kim_daeri', '2048', 2002, '2026-05-19T04:08:49.777Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_97908ce3af3240289a5fd6685ab3f71f', 'seed_usr_kim_daeri', '2048', 5789, '2026-05-19T04:18:14.068Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_54c00947521e424d89d7318708a997a5', 'seed_usr_kim_daeri', 'sudoku', 4189, '2026-05-19T05:23:35.857Z', 150, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c3b6eb0117814396bb6d055c228965f5', 'seed_usr_kim_daeri', 'sudoku', 2813, '2026-05-20T03:16:57.769Z', 129, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3d3997dd1c5647038e404396d5956215', 'seed_usr_kim_daeri', '2048', 5375, '2026-05-21T04:16:31.547Z', 156, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_799f3f9976c5459d90e508ea66e677cf', 'seed_usr_kim_daeri', '2048', 6119, '2026-05-21T04:28:36.307Z', 113, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_31dae2b5f41142f3a7492b7b9a7d9ac2', 'seed_usr_kim_daeri', 'sudoku', 2242, '2026-05-21T04:32:55.717Z', 288, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3fdd16c58791407da5cb0e774e3e2fac', 'seed_usr_kim_daeri', '2048', 3803, '2026-05-22T03:06:34.031Z', 37, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6fa575a27bcd4134b7856d0dd73fc3bc', 'seed_usr_kim_daeri', 'sudoku', 3840, '2026-05-22T03:18:07.947Z', 262, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_13d3db69a3df4e9cadabf087a519fc88', 'seed_usr_kim_daeri', '2048', 9330, '2026-05-22T03:14:43.515Z', 144, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_16e8f43f3df14ceb94c3f1d9cf0806ce', 'seed_usr_kim_daeri', 'sudoku', 3467, '2026-05-25T04:05:29.547Z', 183, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_dd611e1da92e4c7cbea6c37cc04b8cef', 'seed_usr_kim_daeri', '2048', 6846, '2026-05-26T03:42:28.841Z', 37, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d5b5c2cf3aa449e58adfcf79ed1829d0', 'seed_usr_kim_daeri', 'sudoku', 4071, '2026-05-27T04:27:40.631Z', 154, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_312646158cd845ba9150446f58126242', 'seed_usr_kim_daeri', 'sudoku', 4106, '2026-05-27T04:32:33.816Z', 48, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_183b212a235f479f8d5f8748440562d3', 'seed_usr_kim_daeri', '2048', 5919, '2026-05-27T04:33:14.415Z', 148, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_aacd349b51c848ae90e31db7a6661d38', 'seed_usr_kim_daeri', '2048', 4205, '2026-05-27T05:37:08.279Z', 30, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c16f4c514c184cc289acd09134a06429', 'seed_usr_park_staff', '2048', 3378, '2026-05-04T06:30:56.563Z', 101, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3268f42c30dd4ac3a00703a89420bc16', 'seed_usr_park_staff', '2048', 3977, '2026-05-05T05:33:26.985Z', 34, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c5b8ca9e8c014914b6c0e6e97efd4cc6', 'seed_usr_park_staff', '2048', 3296, '2026-05-05T05:37:18.795Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3a7786a1cfd34555ae48dab8bb05b40b', 'seed_usr_park_staff', 'sudoku', 2082, '2026-05-06T05:23:12.963Z', 96, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_96fce4e3c0fe4ec0942f11c1bdc139d9', 'seed_usr_park_staff', 'sudoku', 2153, '2026-05-06T05:35:00.757Z', 124, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8fb2fe8f8c924fa8a3e5988f433b09eb', 'seed_usr_park_staff', 'sudoku', 2265, '2026-05-07T06:24:26.815Z', 196, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b27a13f574db498595c4a00b69bb9916', 'seed_usr_park_staff', 'sudoku', 3224, '2026-05-07T06:36:20.379Z', 199, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_071a62bde1554edd918e07fbad724dd1', 'seed_usr_park_staff', '2048', 1520, '2026-05-11T06:11:22.464Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d950ace1cc124f1da6a42d6159665f06', 'seed_usr_park_staff', 'sudoku', 3006, '2026-05-12T07:02:19.723Z', 166, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b3c73d50433c42c8938d762a5290c488', 'seed_usr_park_staff', 'sudoku', 3101, '2026-05-13T05:40:18.676Z', 196, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a58c75b4cbc246259aa2ddfb223cd00f', 'seed_usr_park_staff', '2048', 3282, '2026-05-15T05:16:25.496Z', 83, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_972178e6fbd34eb1a7bcf8dc26b86c38', 'seed_usr_park_staff', 'sudoku', 2280, '2026-05-15T05:26:03.027Z', 189, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_970cc9cc74e34a45b729d104c63d5389', 'seed_usr_park_staff', '2048', 2403, '2026-05-15T05:26:04.378Z', 164, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_931462885f934b6f8a3260768d704b4b', 'seed_usr_park_staff', 'sudoku', 2373, '2026-05-18T05:27:32.884Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_94b609c78def4e45a249d5d966fa79e6', 'seed_usr_park_staff', 'sudoku', 1450, '2026-05-19T05:36:51.723Z', 266, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1d90ee18bbfa4b319eb44fdbf07968e8', 'seed_usr_park_staff', 'sudoku', 1231, '2026-05-19T05:44:17.348Z', 167, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0d1e3e77398c4d93ba87e0a70c345b25', 'seed_usr_park_staff', 'sudoku', 2027, '2026-05-19T05:54:35.147Z', 114, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_44e3104863a742d79c9251d197168074', 'seed_usr_park_staff', 'sudoku', 3059, '2026-05-20T07:26:48.103Z', 67, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ad76102b97a24105b2e70232f2626543', 'seed_usr_park_staff', 'sudoku', 1957, '2026-05-20T07:34:14.338Z', 198, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d41f9852aac446988e733a8a97427d2f', 'seed_usr_park_staff', '2048', 5590, '2026-05-20T07:44:26.685Z', 134, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6ac137729e964b64b53fa3a49b93e555', 'seed_usr_park_staff', 'sudoku', 3431, '2026-05-21T07:34:58.667Z', 162, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0052560023ca4ee6a996c29cfbc12bc2', 'seed_usr_park_staff', 'sudoku', 1642, '2026-05-21T07:43:33.716Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_87cc0859eee64d75ada8a26a1c2d3968', 'seed_usr_park_staff', 'sudoku', 1937, '2026-05-21T07:58:36.343Z', 289, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_22546cfa8b10478e9c209eded4598d98', 'seed_usr_park_staff', 'sudoku', 3071, '2026-05-25T06:31:52.457Z', 184, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7e9eb9a9f0de4a8c8ee5d1ca2b04d1ba', 'seed_usr_park_staff', 'sudoku', 3177, '2026-05-25T06:39:09.274Z', 272, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9c47cdacda954223baced64b7ea92c7f', 'seed_usr_park_staff', 'sudoku', 1711, '2026-05-26T07:41:45.808Z', 163, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b7e191160e9d41bdb0fbd86878bbbe96', 'seed_usr_park_staff', 'sudoku', 2653, '2026-05-26T07:44:31.595Z', 45, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_976955c8d1ef48b887be36ec9a8bae48', 'seed_usr_park_staff', 'sudoku', 3424, '2026-05-27T05:34:37.736Z', 242, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9e9c37ae2ae04b3d9e46c1096b11d46a', 'seed_usr_lee_manager', '2048', 9175, '2026-05-07T00:13:39.780Z', 74, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_17575822a7fb4564985967a4cb6af314', 'seed_usr_lee_manager', '2048', 5693, '2026-05-07T00:22:15.720Z', 39, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_930d6472edc645bba17f7c1d041fb68b', 'seed_usr_lee_manager', 'typing_game', 4651, '2026-05-07T00:31:43.184Z', 91, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_22889d02215a4e12a822d08b816c8e8e', 'seed_usr_lee_manager', 'typing_game', 2575, '2026-05-08T01:31:30.949Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ed8a748cf292456c848f1f717f4e31cf', 'seed_usr_lee_manager', 'typing_game', 2056, '2026-05-08T01:35:20.472Z', 66, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7eab0d20f7a349ca92a84cce705ce4ad', 'seed_usr_lee_manager', 'typing_game', 4825, '2026-05-14T00:16:02.097Z', 48, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_171d91801ce64db3af99314212433b22', 'seed_usr_lee_manager', 'typing_game', 2440, '2026-05-14T00:19:48.896Z', 98, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d415a593cdfa44c293603353d01a67b0', 'seed_usr_lee_manager', 'typing_game', 5409, '2026-05-14T00:28:23.211Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7a451e544658477593bc2b18651d3cc2', 'seed_usr_lee_manager', 'typing_game', 3858, '2026-05-14T01:38:24.299Z', 103, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5281e778745e49d8a77e5c4f3b951fb8', 'seed_usr_lee_manager', 'typing_game', 5150, '2026-05-18T01:28:01.558Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_604bc469d3a346309b997782c943800c', 'seed_usr_lee_manager', 'typing_game', 4859, '2026-05-18T01:37:26.782Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_14c3b8d3fbc84b56acc05c8a4853a383', 'seed_usr_lee_manager', 'typing_game', 3920, '2026-05-18T01:46:42.469Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7b971049254a413fbcc0b8e173b0ed47', 'seed_usr_lee_manager', '2048', 2179, '2026-05-18T02:36:48.131Z', 131, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7d7c27ecf35a494db83360b4923ab109', 'seed_usr_lee_manager', 'typing_game', 3247, '2026-05-20T01:04:32.788Z', 79, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_db384a285f19451083ff35b800fb1a7d', 'seed_usr_lee_manager', 'typing_game', 4659, '2026-05-20T01:09:17.069Z', 93, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_db53a45fa38f46baa0392368dce36fce', 'seed_usr_lee_manager', 'typing_game', 5104, '2026-05-22T01:31:47.152Z', 55, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c85bfcf99a8649888cc656e1e0c0e303', 'seed_usr_lee_manager', 'typing_game', 4265, '2026-05-22T01:42:59.753Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0b8fa4f33cbd4a5b9e83cb23a09da6b6', 'seed_usr_lee_manager', '2048', 7694, '2026-05-27T00:32:51.299Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ebf61575b8c948ef8f010e4ef6a19700', 'seed_usr_lee_manager', 'typing_game', 3756, '2026-05-27T00:36:44.526Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a9c159b0805346a6a4896188e9d054c9', 'seed_usr_choi_junior', '2048', 1695, '2026-04-30T09:31:39.093Z', 42, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b59acb2d3c8f4d8fb0bb7618c5266038', 'seed_usr_choi_junior', '2048', 1172, '2026-04-30T09:40:44.262Z', 81, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_302c7c650f1d46a5af08712c6e24c2b2', 'seed_usr_choi_junior', '2048', 1045, '2026-04-30T09:39:27.996Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_48c5ec769eff44b2aec1e23390958e23', 'seed_usr_choi_junior', '2048', 2403, '2026-05-01T09:10:07.173Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1d732b1b4d064c5488790d99c98ace0b', 'seed_usr_choi_junior', 'sudoku', 694, '2026-05-02T08:04:42.073Z', 127, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8c672724561c4e3f9526d40968b3773e', 'seed_usr_choi_junior', '2048', 881, '2026-05-02T08:07:49.949Z', 35, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_47771d771b8c42208aedfc198d11831b', 'seed_usr_choi_junior', '2048', 1769, '2026-05-06T09:17:15.755Z', 106, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_11ade4e3a56c4d97a5b9090ecf90f622', 'seed_usr_choi_junior', '2048', 3183, '2026-05-06T09:28:49.366Z', 158, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_89c2965dc5424aad977f8a5c6fbbcc3c', 'seed_usr_choi_junior', '2048', 3365, '2026-05-06T09:27:55.551Z', 36, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f82d6c8e551c4530b3be0f1485a13a82', 'seed_usr_choi_junior', 'sudoku', 879, '2026-05-07T09:38:08.931Z', 113, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2b4c24251b5e4ff5900456404f756630', 'seed_usr_choi_junior', '2048', 2922, '2026-05-07T09:47:53.638Z', 76, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_069207680848418c8eb3a21fb963121a', 'seed_usr_choi_junior', '2048', 3637, '2026-05-09T09:17:45.725Z', 156, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a9c5a75a691544e7a1e6ea8de4bafef4', 'seed_usr_choi_junior', '2048', 3966, '2026-05-11T09:35:21.818Z', 90, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_adba628c4e5641bf95bb99638532e5fa', 'seed_usr_choi_junior', '2048', 991, '2026-05-12T08:20:14.557Z', 123, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_83167972f9f64919a039ec1a90933dc8', 'seed_usr_choi_junior', '2048', 2773, '2026-05-14T08:00:08.302Z', 132, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_35613c1b21b848a0ba82b44c647c8be5', 'seed_usr_choi_junior', 'sudoku', 2199, '2026-05-17T09:11:58.980Z', 103, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7c3a3f0a38f3468c97b67413636a7ebf', 'seed_usr_choi_junior', '2048', 1861, '2026-05-18T09:29:30.542Z', 70, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_88fa284c77c0499f861f80aa9dc5c5db', 'seed_usr_choi_junior', '2048', 2513, '2026-05-18T09:40:49.065Z', 159, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fbeb93a4d66740b8bacf7fd312354609', 'seed_usr_choi_junior', '2048', 1602, '2026-05-19T08:03:00.849Z', 100, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_139aea63153b44929fad7cead3bcaba3', 'seed_usr_choi_junior', '2048', 1534, '2026-05-19T08:09:23.168Z', 165, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b921e7c16626402dbba43174f51f8cf6', 'seed_usr_choi_junior', '2048', 1510, '2026-05-19T08:27:01.599Z', 125, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7cd6b71f4f184863acc029470bb2a859', 'seed_usr_choi_junior', '2048', 2080, '2026-05-21T08:22:50.495Z', 153, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_45e98af8918e4e3e8ffdea87f65b7cc1', 'seed_usr_choi_junior', '2048', 2293, '2026-05-21T08:26:04.878Z', 180, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3a606ef618f24af4b13191013c8d6dbb', 'seed_usr_choi_junior', '2048', 3359, '2026-05-21T08:38:12.763Z', 56, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5705686e408047219bbdd21e12b80837', 'seed_usr_choi_junior', '2048', 2706, '2026-05-25T08:05:42.583Z', 73, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_dfe0ec09dcd645b99cd69f9ccbe10d03', 'seed_usr_choi_junior', '2048', 985, '2026-05-26T09:15:08.056Z', 113, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5f87410691cc45899f25f9cec9c2e708', 'seed_usr_choi_junior', 'sudoku', 1980, '2026-05-26T09:25:35.205Z', 282, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fd857bd7cd454d739ce48a48044d48b8', 'seed_usr_choi_junior', '2048', 3394, '2026-05-26T09:37:48.530Z', 53, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3729257c5b1a4249b701a17fedba2971', 'seed_usr_jung_intern', 'typing_game', 1440, '2026-04-29T15:43:06.701Z', 109, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4058c72c613f43a4add034ac79e1ac44', 'seed_usr_jung_intern', 'sudoku', 639, '2026-04-29T15:50:37.051Z', 195, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cf6abdc8f6a84fb592bb559e2cd7a6bf', 'seed_usr_jung_intern', 'sudoku', 452, '2026-05-01T14:11:27.720Z', 94, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9db5a2e2061548cfa24872c8225ebf99', 'seed_usr_jung_intern', 'sudoku', 941, '2026-05-01T14:14:17.913Z', 151, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f37196f3334c4680a2d041dec59ea33e', 'seed_usr_jung_intern', 'sudoku', 1115, '2026-05-01T15:03:48.257Z', 124, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7090b87fe5d24a869f6d3e38ee883605', 'seed_usr_jung_intern', 'sudoku', 1080, '2026-05-05T15:16:46.221Z', 244, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f14b70f7aeb2428297fe894854795082', 'seed_usr_jung_intern', 'sudoku', 1079, '2026-05-07T14:43:53.742Z', 173, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_0cb1a8478b95489eb9b175500a9448f3', 'seed_usr_jung_intern', 'sudoku', 1006, '2026-05-09T14:27:07.637Z', 131, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b0a2f06f8288403b8f06f4bcf6046413', 'seed_usr_jung_intern', 'typing_game', 1049, '2026-05-09T14:39:08.316Z', 98, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_fdbe9da12bc84863bcf407922d26aa4a', 'seed_usr_jung_intern', 'typing_game', 1233, '2026-05-14T13:09:40.677Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_77c804e7359245df989e4c3194d58a9f', 'seed_usr_jung_intern', 'sudoku', 725, '2026-05-14T15:16:26.153Z', 211, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8e0ade666cb64483b9aac5850a23ee30', 'seed_usr_jung_intern', 'typing_game', 602, '2026-05-14T15:23:39.229Z', 57, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5ca1e0b0b45b4106a3fc279f2e91fe61', 'seed_usr_jung_intern', 'sudoku', 953, '2026-05-17T14:45:54.342Z', 216, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_52da17d1f39c4760b449c942f2e706ba', 'seed_usr_jung_intern', 'typing_game', 203, '2026-05-19T13:27:21.766Z', 107, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d12390757e594aeb9e9cf40086a39fb2', 'seed_usr_jung_intern', 'typing_game', 515, '2026-05-20T14:06:58.489Z', 84, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_65c22695376340c9a8f976648d0fa202', 'seed_usr_yoon_mgr', 'sudoku', 5406, '2026-04-30T01:41:28.316Z', 183, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_698344cace5f4284bd6ef890240fad7c', 'seed_usr_yoon_mgr', 'sudoku', 5155, '2026-04-30T01:50:17.620Z', 194, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_33e08b71cd6540b2b6f0753e44cb4508', 'seed_usr_yoon_mgr', 'sudoku', 3826, '2026-05-01T02:34:12.436Z', 271, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4ecdcad83dfc44699a85f04efb1e8fed', 'seed_usr_yoon_mgr', 'sudoku', 3906, '2026-05-01T02:42:11.586Z', 181, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a1926b73394a46cdb5082cb463c69363', 'seed_usr_yoon_mgr', 'sudoku', 3183, '2026-05-04T02:05:35.846Z', 191, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ecd30f30bbf842cc81cac9847ad61644', 'seed_usr_yoon_mgr', '2048', 3512, '2026-05-04T02:17:07.933Z', 180, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1a538841527a4e8986aa923236c8d26c', 'seed_usr_yoon_mgr', 'sudoku', 3027, '2026-05-04T02:19:13.059Z', 291, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6ffb3d36c777432caad779fb2fd9d543', 'seed_usr_yoon_mgr', 'sudoku', 2986, '2026-05-06T01:05:04.860Z', 170, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_10486390ca0b4173ad3f678ea21e0065', 'seed_usr_yoon_mgr', 'sudoku', 6273, '2026-05-06T01:13:06.374Z', 54, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_b61df58d581d495d93d02e8ab4a245c2', 'seed_usr_yoon_mgr', 'sudoku', 6070, '2026-05-06T01:23:14.347Z', 114, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ec323350b0764975863470e2733fba6c', 'seed_usr_yoon_mgr', 'sudoku', 5752, '2026-05-06T02:55:44.414Z', 174, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_dfe113694b974a538e5de42c1f0b927c', 'seed_usr_yoon_mgr', 'sudoku', 3422, '2026-05-07T02:01:09.119Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_59ef66c7e366443f9af02bd856423397', 'seed_usr_yoon_mgr', '2048', 9108, '2026-05-07T02:04:41.131Z', 163, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9aabed623397435d82c73995b041333d', 'seed_usr_yoon_mgr', '2048', 9522, '2026-05-07T02:23:21.993Z', 84, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c4c406a91adf455c84855f2fd209761c', 'seed_usr_yoon_mgr', 'sudoku', 4686, '2026-05-11T02:31:54.314Z', 81, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c7916e00ac0845cdad68c7707fb63bb1', 'seed_usr_yoon_mgr', 'sudoku', 6116, '2026-05-11T02:42:11.574Z', 103, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8b0d799ac4ca4ed5b27a3092c124a0c2', 'seed_usr_yoon_mgr', 'sudoku', 3454, '2026-05-11T02:45:33.892Z', 45, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9c560ad9ac2f4ff5899f0427a2d044b9', 'seed_usr_yoon_mgr', '2048', 13291, '2026-05-11T03:40:46.091Z', 132, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6779fc877cde4b2383e155c98c060b6f', 'seed_usr_yoon_mgr', 'sudoku', 3506, '2026-05-11T03:59:40.412Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_92f6f23492774de6a46b7c9d0e358e6d', 'seed_usr_yoon_mgr', 'sudoku', 5692, '2026-05-12T02:05:58.298Z', 167, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c481b2554e80453db3381f28067e5019', 'seed_usr_yoon_mgr', 'sudoku', 5032, '2026-05-12T02:17:18.563Z', 53, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9a343574c9d044f88cabfef8f2685a22', 'seed_usr_yoon_mgr', 'sudoku', 3516, '2026-05-12T02:13:52.247Z', 50, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_8c7583fcdfc54bdb94ca13a192478e8f', 'seed_usr_yoon_mgr', 'sudoku', 4436, '2026-05-12T03:30:33.408Z', 93, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ae6ffdcf75614cecb9af70b1906a91fd', 'seed_usr_yoon_mgr', 'sudoku', 6214, '2026-05-12T03:51:27.882Z', 161, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_7dcb7caf060240c0b78b1f988cbefd4b', 'seed_usr_yoon_mgr', 'sudoku', 6384, '2026-05-13T02:01:09.992Z', 298, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9ed4995aefa9476881cf3c9c576fce70', 'seed_usr_yoon_mgr', 'sudoku', 3242, '2026-05-18T01:19:01.906Z', 163, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4f216ede4cd6425f8af13e116b3587f4', 'seed_usr_yoon_mgr', 'sudoku', 3736, '2026-05-18T01:27:49.383Z', 201, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3ecadc493e134687a1d6fc48e7c2ff6f', 'seed_usr_yoon_mgr', '2048', 7273, '2026-05-20T01:25:59.507Z', 43, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f9f504fc39eb4ee289686092bd627661', 'seed_usr_yoon_mgr', '2048', 6146, '2026-05-22T02:12:12.329Z', 39, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_344f977b7ee6488ba0951f5ff2e50b12', 'seed_usr_yoon_mgr', 'sudoku', 3279, '2026-05-22T02:22:19.384Z', 84, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_80f947c84a854c96af469b7f9c14b6ba', 'seed_usr_yoon_mgr', 'sudoku', 4444, '2026-05-22T02:26:10.894Z', 175, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_00b54125e2ee44d1afe483faee54426d', 'seed_usr_yoon_mgr', 'sudoku', 3199, '2026-05-22T03:35:58.079Z', 116, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_cb41e7a62e09443ba28d2f165421db4d', 'seed_usr_yoon_mgr', '2048', 7060, '2026-05-22T03:58:31.990Z', 51, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2d348c362f66430a9ec21ca898e9332e', 'seed_usr_oh_lead', 'typing_game', 3911, '2026-04-30T04:18:44.060Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_210b95b077db4c7f9d794433eef62802', 'seed_usr_oh_lead', 'typing_game', 3981, '2026-04-30T04:27:19.366Z', 95, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f6c6bd7a472741aa8d4f272b4ba23bad', 'seed_usr_oh_lead', 'typing_game', 4684, '2026-05-04T04:23:37.750Z', 60, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_61c6d60acc5144968b18dd115598bc34', 'seed_usr_oh_lead', 'typing_game', 6949, '2026-05-04T04:28:39.288Z', 55, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_c176cfddadef4c0083d761c2390109a5', 'seed_usr_oh_lead', 'sudoku', 3701, '2026-05-04T04:35:04.984Z', 165, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6abb896ac1694bcf8ce8c3b21fc0af47', 'seed_usr_oh_lead', 'sudoku', 4055, '2026-05-08T04:10:53.162Z', 159, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_829f0f64b2c342c28a7e3cdab9f0408b', 'seed_usr_oh_lead', 'typing_game', 5018, '2026-05-08T04:15:36.410Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4c50faabdc53455ba29cad13bd7e3e1a', 'seed_usr_oh_lead', 'typing_game', 3397, '2026-05-08T04:16:59.179Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_dc8678715c3642c49412d55b0f5be723', 'seed_usr_oh_lead', 'sudoku', 6471, '2026-05-11T05:15:52.620Z', 190, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2a6a5f2f682d45f8a7c5c75417bb289e', 'seed_usr_oh_lead', 'typing_game', 5448, '2026-05-11T05:19:10.703Z', 103, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_ccb6eb01beb143d3bbab72eb66e499d5', 'seed_usr_oh_lead', 'typing_game', 5228, '2026-05-11T05:33:45.287Z', 55, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_4f8ddd97e7bf4d58b53414f0694c212c', 'seed_usr_oh_lead', 'typing_game', 5086, '2026-05-11T06:33:18.643Z', 86, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_775df2f82feb4f90bb895e16de6732b4', 'seed_usr_oh_lead', 'typing_game', 4892, '2026-05-11T06:19:55.370Z', 118, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_099f6f252c594a0eab42ebd8bc53e8ee', 'seed_usr_oh_lead', 'typing_game', 5861, '2026-05-12T04:38:05.932Z', 59, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_2d5b3cbdf67a49f19aad5e1957c4836d', 'seed_usr_oh_lead', 'sudoku', 4467, '2026-05-12T04:45:11.632Z', 159, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_64df4a628fe640d3a83898f139b496d1', 'seed_usr_oh_lead', 'typing_game', 3426, '2026-05-12T04:59:36.296Z', 57, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_611a3a6ac7004ca2b52263b6a5e51589', 'seed_usr_oh_lead', 'typing_game', 4497, '2026-05-12T05:46:10.817Z', 86, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f6e9b61c259247de90f76597e06e7e63', 'seed_usr_oh_lead', 'typing_game', 3659, '2026-05-12T05:42:19.635Z', 112, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_d0de442f1807497c83c92d36a19a9f22', 'seed_usr_oh_lead', 'typing_game', 3322, '2026-05-13T05:29:01.577Z', 77, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_63d99adcf8c04fcc898e6e5e717631d8', 'seed_usr_oh_lead', 'sudoku', 4798, '2026-05-13T05:39:20.861Z', 81, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_9b913d3de6e8496894385d5dddbe8d55', 'seed_usr_oh_lead', 'typing_game', 5614, '2026-05-18T04:28:10.819Z', 54, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_5ac9e33ac54941fcbeeaec4ec27abea0', 'seed_usr_oh_lead', 'sudoku', 4104, '2026-05-18T04:40:36.504Z', 72, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_6af708829c324294bd4f5920e15c3a58', 'seed_usr_oh_lead', 'typing_game', 4723, '2026-05-18T04:44:56.549Z', 45, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_dabf85048ed048989f845df2ffeb1254', 'seed_usr_oh_lead', 'typing_game', 5581, '2026-05-19T05:07:33.112Z', 111, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_967b8930d4b54ab7b3deb13cde74b6db', 'seed_usr_oh_lead', 'sudoku', 3601, '2026-05-20T04:06:24.667Z', 87, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_60f9c4c35a3f4decb41870d19d17e2f7', 'seed_usr_oh_lead', 'sudoku', 3826, '2026-05-21T04:03:59.824Z', 174, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_1f819ef4282e4f91b7f4fe5e47d9dffb', 'seed_usr_oh_lead', 'sudoku', 4867, '2026-05-21T04:12:06.034Z', 173, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_a5131ea9fc2946f4907c56b550cdeefc', 'seed_usr_oh_lead', 'typing_game', 6380, '2026-05-21T04:13:56.038Z', 97, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_949ac1f537eb47afba7be41c8e8f36ba', 'seed_usr_oh_lead', 'typing_game', 6827, '2026-05-21T05:31:59.538Z', 71, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f39d0738489e48c2b748b5bff4dc2307', 'seed_usr_oh_lead', 'typing_game', 5785, '2026-05-22T05:02:33.192Z', 74, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_3be0e498f6b34e22bbcef515f6dda43d', 'seed_usr_oh_lead', 'typing_game', 6037, '2026-05-26T05:40:12.143Z', 49, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_654c864a4e77407babf44942e2b807a0', 'seed_usr_oh_lead', 'typing_game', 3999, '2026-05-26T05:51:41.723Z', 82, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('seed_gsc_f843da9d71c54bd8939375388fd2bca5', 'seed_usr_oh_lead', 'sudoku', 3376, '2026-05-27T04:42:16.465Z', 262, '{"seed":true,"source":"seed"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_fbbebd48638247a7aa770b6da79a3b08', 'npc_usr_qa_bot', 'typing_game', 2662, '2026-05-01T05:19:33.903Z', 120, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_1238af7d115442179deaaf055658e8da', 'npc_usr_qa_bot', 'typing_game', 3021, '2026-05-01T05:31:39.256Z', 81, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_60c60da461994c10a82c37a58745c63e', 'npc_usr_qa_bot', '2048', 2748, '2026-05-01T05:37:24.754Z', 158, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e49b639e292744f1ac6c60a583ac1d7e', 'npc_usr_qa_bot', 'typing_game', 2540, '2026-05-01T06:37:49.030Z', 70, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_540dd8b014664a75b6e46bb5c9600e1b', 'npc_usr_qa_bot', 'typing_game', 1962, '2026-05-01T06:34:28.990Z', 73, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_fa3c22abcbb74d22b2fc504b17f2d1d0', 'npc_usr_qa_bot', '2048', 3755, '2026-05-01T06:59:30.464Z', 145, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_85ea995ae468423793aaf7b76daea443', 'npc_usr_qa_bot', 'typing_game', 3133, '2026-05-06T01:36:16.239Z', 63, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a0e192fc2ab84d3591d47760d3b23727', 'npc_usr_qa_bot', '2048', 2058, '2026-05-06T01:44:48.686Z', 61, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_74d9385830374329aac998ca2adf62a5', 'npc_usr_qa_bot', 'typing_game', 400, '2026-05-06T01:52:31.215Z', 97, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_fbdc49e51f894c92ac889b694794aede', 'npc_usr_qa_bot', 'typing_game', 2409, '2026-05-06T02:35:05.855Z', 114, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_130df503aebd4cf1b6de3f96d0f34232', 'npc_usr_qa_bot', 'typing_game', 1600, '2026-05-06T02:38:20.564Z', 45, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c0f852f48b014844bffb3f3d0a46f190', 'npc_usr_qa_bot', 'typing_game', 510, '2026-05-06T02:32:47.077Z', 74, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9534c7528838411b8a17e23187248884', 'npc_usr_qa_bot', 'typing_game', 750, '2026-05-08T01:41:16.357Z', 77, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_8f951106cffe489bb1d17aa0beee85c6', 'npc_usr_qa_bot', 'typing_game', 2554, '2026-05-08T01:49:47.576Z', 51, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_cf5d4b140a4c42e9876c74ef9af9b99c', 'npc_usr_qa_bot', 'typing_game', 3757, '2026-05-08T01:57:14.436Z', 43, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_ccfce70b382b426c8c43d1bcd878c538', 'npc_usr_qa_bot', 'typing_game', 501, '2026-05-08T02:48:14.917Z', 59, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6d7bdd531b07436d8fde8e6cbff58b25', 'npc_usr_qa_bot', 'typing_game', 1048, '2026-05-08T02:34:18.675Z', 107, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f1f2e64f31de4ea684e1c9bf720978a2', 'npc_usr_qa_bot', '2048', 2159, '2026-05-08T02:59:26.568Z', 44, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f335e6dc87a74243ade59c30de3f30a5', 'npc_usr_qa_bot', 'typing_game', 2090, '2026-05-11T02:29:39.299Z', 79, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_43108f60f1cc4650843678cb322d163a', 'npc_usr_qa_bot', 'typing_game', 3088, '2026-05-11T02:39:43.945Z', 47, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_4d3ebb9676344ce7b97608e6f513cea4', 'npc_usr_qa_bot', 'typing_game', 3425, '2026-05-11T02:39:36.903Z', 65, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_44224241777b46a29a511a54cc9aef34', 'npc_usr_qa_bot', 'typing_game', 2602, '2026-05-11T03:31:14.808Z', 78, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a4cf336caab54123ba80957e5df3429e', 'npc_usr_qa_bot', 'typing_game', 2544, '2026-05-11T03:22:40.875Z', 41, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_902a3176389842d09ebcd1440b32b744', 'npc_usr_qa_bot', 'typing_game', 3617, '2026-05-11T03:55:06.381Z', 80, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7e8e571ac271403aa71fc0256b0edfc7', 'npc_usr_qa_bot', 'typing_game', 3112, '2026-05-15T01:05:14.432Z', 67, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9eaca849418c4c5eaeae94af8d770832', 'npc_usr_qa_bot', 'typing_game', 442, '2026-05-15T01:16:04.723Z', 44, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_512e2d97f69f48088bff6f7c93ce80f1', 'npc_usr_qa_bot', 'typing_game', 2075, '2026-05-15T01:29:36.401Z', 90, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_51d94cc8784f466ea6595aea9b0c66a3', 'npc_usr_qa_bot', 'typing_game', 1620, '2026-05-15T02:31:07.128Z', 115, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_fa3c33f1343d42a9be2ec58cae8fd915', 'npc_usr_qa_bot', 'typing_game', 1059, '2026-05-15T02:48:20.240Z', 48, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_bf3852ac5c2047bdb9d15234730b847c', 'npc_usr_qa_bot', 'typing_game', 2244, '2026-05-18T05:13:27.688Z', 108, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_9ca594b866984a4b8772b2a6beb1a365', 'npc_usr_qa_bot', '2048', 3787, '2026-05-18T05:18:08.452Z', 113, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f9e6be11f6b844de9b432803460acaae', 'npc_usr_qa_bot', '2048', 1542, '2026-05-18T05:33:51.256Z', 117, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_13a51350bf0742b98f91b1cfec6a8b21', 'npc_usr_qa_bot', 'typing_game', 1023, '2026-05-18T06:26:45.757Z', 44, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_02757f6a18274b4eba0d2a1678731e78', 'npc_usr_qa_bot', '2048', 4768, '2026-05-18T06:46:38.883Z', 165, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e464a42cbc894421b690812c96078dd8', 'npc_usr_qa_bot', 'typing_game', 416, '2026-05-20T07:18:46.534Z', 92, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c217d70c755f40a5b419b2f7327dd364', 'npc_usr_qa_bot', 'typing_game', 1450, '2026-05-20T07:30:55.298Z', 108, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_73cd9fbd429a414f85d2843688da4a32', 'npc_usr_qa_bot', 'typing_game', 2407, '2026-05-22T06:01:46.483Z', 41, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_18f11c1ff23c4143a408c819917a193b', 'npc_usr_qa_bot', '2048', 4210, '2026-05-22T06:08:28.125Z', 167, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_753c51e7825c45738a0f66f48b605e11', 'npc_usr_qa_bot', '2048', 3266, '2026-05-22T06:23:12.082Z', 32, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7a5da279f1064563bf817535539257e0', 'npc_usr_qa_bot', '2048', 818, '2026-05-22T07:34:44.045Z', 122, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6408ffb282334b08b9d30db879a32920', 'npc_usr_qa_bot', 'typing_game', 2051, '2026-05-25T02:40:49.529Z', 116, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_025b57eb5636463984801da26a1c1a9e', 'npc_usr_qa_bot', '2048', 1247, '2026-05-25T02:48:22.315Z', 72, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_761b5b92d83948bcb09036eaa1bcd70a', 'npc_usr_qa_bot', 'typing_game', 1484, '2026-05-25T02:56:49.864Z', 109, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5bcd428e45ff48af8e5b6e5900e8f6a1', 'npc_usr_qa_bot', 'typing_game', 3500, '2026-05-27T05:22:17.345Z', 107, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5006df7545f041e68cf4c2e6a2a5b301', 'npc_usr_qa_bot', '2048', 3343, '2026-05-27T05:28:13.218Z', 71, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a03821f06a5444c7a64634d2ce2bcb47', 'npc_usr_kim_daeri', '2048', 3095, '2026-04-30T02:15:37.050Z', 65, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_bfeb5f6232c848988224699362189364', 'npc_usr_kim_daeri', '2048', 1551, '2026-04-30T02:23:02.448Z', 107, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_eae5df447b4b4769a31a3b439c56c498', 'npc_usr_kim_daeri', 'sudoku', 3229, '2026-04-30T02:37:36.120Z', 226, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f84b9c9f9d364621a78193b1423488f5', 'npc_usr_kim_daeri', '2048', 688, '2026-05-03T02:31:07.250Z', 71, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_2b2c23919ced44149501c9fe57d329c9', 'npc_usr_kim_daeri', '2048', 4628, '2026-05-03T02:37:01.131Z', 167, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_dc97a20a278e43e98c261e12abadc782', 'npc_usr_kim_daeri', 'sudoku', 1315, '2026-05-03T02:41:20.371Z', 175, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_338cf43c05e24243a7a211783311f8c6', 'npc_usr_kim_daeri', '2048', 612, '2026-05-06T02:21:42.384Z', 145, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_5cccf0afde6c4937aaae9c4469de0cee', 'npc_usr_kim_daeri', '2048', 1198, '2026-05-06T02:25:06.929Z', 52, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_59d8dfe4a1974fa6a7c6ffd4d9255614', 'npc_usr_kim_daeri', 'sudoku', 3185, '2026-05-06T02:29:11.700Z', 297, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_d79bebc9bafa443fab72c5805539b84c', 'npc_usr_kim_daeri', '2048', 3399, '2026-05-09T02:37:15.337Z', 77, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f30946b9d04b454da8d94f478a2cf16b', 'npc_usr_kim_daeri', '2048', 759, '2026-05-09T02:47:11.442Z', 31, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_da90285ffa5a4b26ac93ca3413161986', 'npc_usr_kim_daeri', 'sudoku', 3307, '2026-05-09T02:53:59.819Z', 52, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6ca04017b37549bda178b9fb390a7404', 'npc_usr_kim_daeri', '2048', 2447, '2026-05-12T02:11:57.169Z', 157, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e5b5c701369b48849be5fb9d630aee0e', 'npc_usr_kim_daeri', '2048', 3066, '2026-05-12T02:16:49.146Z', 36, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_4bd6225e6a964728a9f06c7d77cbd1da', 'npc_usr_kim_daeri', 'sudoku', 1872, '2026-05-12T02:19:24.671Z', 83, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_20530351f14e4c38a01cbfe73e726cec', 'npc_usr_kim_daeri', '2048', 2859, '2026-05-15T02:43:12.241Z', 137, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_322a9c55eb6e496c9116f2b6551af876', 'npc_usr_kim_daeri', '2048', 4183, '2026-05-15T02:55:56.473Z', 32, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0f3dded844f449a3a781dc424a6c0519', 'npc_usr_kim_daeri', 'sudoku', 2785, '2026-05-15T02:51:53.184Z', 144, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_3dc489f1a3064cd192d451761bab92be', 'npc_usr_kim_daeri', '2048', 4885, '2026-05-18T02:14:27.836Z', 47, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_6d8ba2b489a04f0ead50f4ac2ed9b58d', 'npc_usr_kim_daeri', '2048', 4267, '2026-05-18T02:22:57.763Z', 160, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_38ac71b9048448429e139351a9c79ee0', 'npc_usr_kim_daeri', 'sudoku', 2910, '2026-05-18T02:34:11.409Z', 113, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c369917837f04ab290fd9562f7c0eec5', 'npc_usr_kim_daeri', '2048', 2076, '2026-05-21T02:42:57.545Z', 57, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e543ca6ab8b245729431ff43a2a77144', 'npc_usr_kim_daeri', '2048', 1308, '2026-05-21T02:46:57.772Z', 65, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f2ca8e97d7694ef2a1042ee7a273b7b3', 'npc_usr_kim_daeri', 'sudoku', 489, '2026-05-21T02:59:33.652Z', 144, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_68b9f7799a00434dbb41762e08880e42', 'npc_usr_kim_daeri', '2048', 986, '2026-05-24T02:12:06.979Z', 100, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_84121dbb040e437cb4d8b9f6915e22c0', 'npc_usr_kim_daeri', '2048', 3925, '2026-05-24T02:24:45.510Z', 43, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_bbfddfe185f842de83dab234d9850779', 'npc_usr_kim_daeri', 'sudoku', 451, '2026-05-24T02:18:52.429Z', 177, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_b392df35ef1c4d299f97d7189e3063fd', 'npc_usr_kim_daeri', '2048', 3079, '2026-05-27T02:16:52.295Z', 93, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_3ebdf73ac40e4786b04e369e4f3c81bc', 'npc_usr_kim_daeri', '2048', 2291, '2026-05-27T02:23:09.673Z', 151, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c5f5ba485acb478b894b47a18be09476', 'npc_usr_kim_daeri', 'sudoku', 446, '2026-05-27T02:32:30.803Z', 228, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_4606f5358264476a96e9a7174c3f5ede', 'npc_usr_todaki', '2048', 2094, '2026-04-30T03:18:52.345Z', 58, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_cdcb8fbe4399478a8cbd9473a461cd59', 'npc_usr_todaki', 'sudoku', 3263, '2026-04-30T03:25:56.576Z', 174, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0da53563b9ae4ff5b92b4ab41cb95f2c', 'npc_usr_todaki', '2048', 3308, '2026-05-01T04:28:25.613Z', 64, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0ae3246fe7864c56bffc30c250e9cb9a', 'npc_usr_todaki', '2048', 3516, '2026-05-04T04:10:04.896Z', 112, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_47f077c748f24c948c8e566fce4a287e', 'npc_usr_todaki', 'sudoku', 754, '2026-05-06T04:21:58.366Z', 66, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_4b37f78bea6b445698f720cce3acaa1b', 'npc_usr_todaki', 'sudoku', 489, '2026-05-08T03:21:35.843Z', 170, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e6d4a7c8ac3d4aa1af6a9f37e7b617c6', 'npc_usr_todaki', '2048', 2328, '2026-05-11T04:06:41.820Z', 85, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_0b0433cc651e437483ac75873fd5575b', 'npc_usr_todaki', 'sudoku', 1580, '2026-05-11T04:15:10.792Z', 242, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_7060599bf15348bba17171ddb8268335', 'npc_usr_todaki', '2048', 1235, '2026-05-12T04:16:44.547Z', 63, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_8726b48302c34b2293e5cbaaff1973b2', 'npc_usr_todaki', '2048', 4036, '2026-05-13T03:41:55.010Z', 120, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_c15873d600554e09b7748f732ea3da67', 'npc_usr_todaki', 'sudoku', 3321, '2026-05-13T03:45:38.876Z', 108, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_48778dbece40454584d528948fd8350c', 'npc_usr_todaki', '2048', 3124, '2026-05-18T03:39:16.315Z', 113, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_cb8c766b20f543f094395bf79898c02e', 'npc_usr_todaki', 'sudoku', 1170, '2026-05-18T03:47:48.507Z', 254, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_3f6cf05e967347758a8dcc7d56c01229', 'npc_usr_todaki', 'sudoku', 2372, '2026-05-20T04:45:00.636Z', 169, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_757e80ce0fa343f89683120bd0895905', 'npc_usr_todaki', 'sudoku', 2042, '2026-05-20T04:54:20.025Z', 47, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_634ea93016544f098b03cb9105711b76', 'npc_usr_todaki', '2048', 1428, '2026-05-21T04:01:12.102Z', 152, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_659c3febcfe7465ca4392cf1fb455f91', 'npc_usr_todaki', 'sudoku', 3105, '2026-05-21T04:13:31.123Z', 252, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f8efadb1b6df4a0cbdc4badee8f44d8b', 'npc_usr_todaki', 'sudoku', 2322, '2026-05-25T03:12:14.968Z', 282, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_f3dbe08ac7fb40d99f94a01145167160', 'npc_usr_todaki', '2048', 2958, '2026-05-26T03:31:39.694Z', 33, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_e2222e05723b4d90920a4bb960123d2b', 'npc_usr_todaki', '2048', 803, '2026-05-26T03:42:41.459Z', 145, '{"seed":true,"source":"npc"}');
INSERT OR IGNORE INTO game_scores (id, user_id, game_type, score, played_at, duration_seconds, extra_json)
VALUES ('npc_gsc_a870ed783b91478a9e73f7d78d91c55b', 'npc_usr_todaki', '2048', 3774, '2026-05-27T03:29:01.928Z', 160, '{"seed":true,"source":"npc"}');

-- Step 5: Point wallets (approximated from total scores / 10)
-- Does not create real point_transactions — admin adjust only
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('seed_usr_kim_daeri', 3382, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_kim_daeri', 3382, 3382, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('seed_usr_park_staff', 4242, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_park_staff', 4242, 4242, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('seed_usr_lee_manager', 3941, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_lee_manager', 3941, 3941, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('seed_usr_choi_junior', 4699, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_choi_junior', 4699, 4699, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('seed_usr_jung_intern', 4873, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_jung_intern', 4873, 4873, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('seed_usr_yoon_mgr', 1192, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_yoon_mgr', 1192, 1192, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('seed_usr_oh_lead', 988, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('seed_usr_oh_lead', 988, 988, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('npc_usr_qa_bot', 4130, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_qa_bot', 4130, 4130, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('npc_usr_kim_daeri', 2867, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_kim_daeri', 2867, 2867, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO point_wallets (user_id, point_balance, updated_at)
VALUES ('npc_usr_todaki', 4229, '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO user_points (user_id, current_points, total_earned_points, total_spent_points, created_at, updated_at)
VALUES ('npc_usr_todaki', 4229, 4229, 0, '2026-05-27T18:20:30.628Z', '2026-05-27T18:20:30.628Z');

-- Step 6: Company tags for seed companies
INSERT OR IGNORE INTO companies (id, name, created_at)
VALUES ('ctag_5206e03bb1dc4c789be3a03b75b2db17', 'Refresheet Office', '2026-05-27T18:20:30.628Z');
INSERT OR IGNORE INTO companies (id, name, created_at)
VALUES ('ctag_47ac2de03d7c4dc6ad6957530090b0d5',  'Refresheet Lab',    '2026-05-27T18:20:30.628Z');

-- Summary: 10 virtual users, ~292 game_score rows
-- Seed accounts (source=seed): 7
-- NPC accounts  (source=npc):  3
-- To verify isolation:
--   SELECT source, is_virtual, COUNT(*) FROM users GROUP BY source, is_virtual;
--   SELECT u.source, COUNT(gs.id) AS plays FROM game_scores gs JOIN users u USING(user_id) GROUP BY u.source;