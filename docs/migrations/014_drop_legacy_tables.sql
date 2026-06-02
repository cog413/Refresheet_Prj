-- Migration 014: Drop legacy/unused tables confirmed empty (COUNT=0)
-- Verified via live D1 query on 2026-06-03.
-- All 11 tables had 0 rows. Safe to drop.

DROP TABLE IF EXISTS user_content_history;
DROP TABLE IF EXISTS character_assets;
DROP TABLE IF EXISTS user_pets;
DROP TABLE IF EXISTS scenario_nodes;
DROP TABLE IF EXISTS scenario_buttons;
DROP TABLE IF EXISTS company_tags;
DROP TABLE IF EXISTS user_company_tags;
DROP TABLE IF EXISTS event_logs;
DROP TABLE IF EXISTS typing_prompts;
DROP TABLE IF EXISTS point_ledger;
DROP TABLE IF EXISTS game_results;
