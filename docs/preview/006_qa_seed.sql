-- Migration 006: QA test account for preview/CI automated testing
-- Apply to PREVIEW DB only (sub.refresheet-prj.pages.dev).
-- NEVER apply to production DB (refresheetkr.com).
--
-- Apply:
--   npx.cmd wrangler d1 execute DB --remote --file=./docs/migrations/006_qa_seed.sql
--
-- QA account: qa_jhchae908p@refresheet.test
-- No google_sub, no OAuth credential, no real personal data.
-- Used only by /api/dev-login endpoint on preview host.

INSERT OR IGNORE INTO users (
    user_id, google_sub, email, company,
    commute_start, commute_end, onboarding_done, marketing_agreed,
    created_at, updated_at
) VALUES (
    'usr_qa_refresheet_test_0001', NULL, 'qa_jhchae908p@refresheet.test',
    'QA팀', '09:00', '18:00', 1, 0,
    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

INSERT OR IGNORE INTO user_profiles (
    user_id, nickname, avatar_url, last_login_at, created_at, updated_at
) VALUES (
    'usr_qa_refresheet_test_0001', 'QA테스터', NULL,
    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

INSERT OR IGNORE INTO avatars (
    user_id, nickname, character_type, character_key, equipped_item_keys,
    created_at, updated_at
) VALUES (
    'usr_qa_refresheet_test_0001', 'QA테스터', 'mong', 'mong', '[]',
    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);
