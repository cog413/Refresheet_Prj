-- Migration 011: users.is_active — invalid/deleted user filtering
-- Apply: npx wrangler d1 migrations apply DB --remote
ALTER TABLE users ADD COLUMN is_active INTEGER NOT NULL DEFAULT 1;
CREATE INDEX IF NOT EXISTS idx_users_is_active
    ON users(is_active) WHERE is_active = 0;
