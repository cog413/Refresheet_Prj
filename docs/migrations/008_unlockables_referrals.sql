-- Migration 008: unlockable sheets/characters and immutable referral email
-- Apply:
--   npx wrangler d1 execute DB --remote --file=./docs/migrations/008_unlockables_referrals.sql
--
-- Existing Refresheet auth uses users.user_id TEXT.
-- Do not change the users primary key shape.

CREATE TABLE IF NOT EXISTS unlockable_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  item_key TEXT NOT NULL UNIQUE,
  item_type TEXT NOT NULL,
  display_name TEXT NOT NULL,
  lock_type TEXT NOT NULL DEFAULT 'none',
  lock_value TEXT,
  lock_reason TEXT,
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_unlockable_items_type
ON unlockable_items(item_type);

CREATE TABLE IF NOT EXISTS user_unlocks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT NOT NULL,
  item_key TEXT NOT NULL,
  unlocked_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  unlock_source TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  UNIQUE(user_id, item_key)
);

CREATE INDEX IF NOT EXISTS idx_user_unlocks_user
ON user_unlocks(user_id);

CREATE TABLE IF NOT EXISTS user_referrals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT NOT NULL UNIQUE,
  referrer_user_id TEXT NOT NULL,
  referrer_email TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  reward_status TEXT NOT NULL DEFAULT 'pending',
  reward_granted_at TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (referrer_user_id) REFERENCES users(user_id)
);

CREATE INDEX IF NOT EXISTS idx_user_referrals_referrer
ON user_referrals(referrer_user_id);

CREATE INDEX IF NOT EXISTS idx_user_referrals_email
ON user_referrals(referrer_email);

INSERT INTO unlockable_items (
  item_key,
  item_type,
  display_name,
  lock_type,
  lock_value,
  lock_reason,
  is_active
)
VALUES (
  'new_game',
  'sheet',
  'NewGame',
  'referral',
  '2',
  '친구추천 2명 달성 시 이용할 수 있습니다',
  1
)
ON CONFLICT(item_key) DO UPDATE SET
  item_type = excluded.item_type,
  display_name = excluded.display_name,
  lock_type = excluded.lock_type,
  lock_value = excluded.lock_value,
  lock_reason = excluded.lock_reason,
  is_active = excluded.is_active,
  updated_at = CURRENT_TIMESTAMP;
