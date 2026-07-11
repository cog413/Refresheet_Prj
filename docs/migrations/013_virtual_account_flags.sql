-- Migration 013: virtual account flags for seed / NPC users
-- Adds source and is_virtual to users table.
-- source: 'real' (default) | 'seed' | 'npc'
-- is_virtual: 0 (default) | 1
-- Apply:
--   npx wrangler d1 migrations apply DB --remote

ALTER TABLE users ADD COLUMN source TEXT NOT NULL DEFAULT 'real';
ALTER TABLE users ADD COLUMN is_virtual INTEGER NOT NULL DEFAULT 0;

-- All existing rows are real users.
UPDATE users SET source = 'real', is_virtual = 0 WHERE is_virtual IS NULL OR is_virtual = 0;

-- Fast lookups: admin filtering, stats separation, seed cleanup.
CREATE INDEX IF NOT EXISTS idx_users_source       ON users(source);
CREATE INDEX IF NOT EXISTS idx_users_is_virtual   ON users(is_virtual) WHERE is_virtual = 1;

-- Seed cron state: tracks start date and decay status.
-- Created here so the cron Worker can assume it exists after this migration.
CREATE TABLE IF NOT EXISTS seed_config (
    key        TEXT PRIMARY KEY,
    value      TEXT NOT NULL,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
