-- Migration 007: Excel review comments, likes, and operator feedback
-- Apply:
--   npx wrangler d1 migrations apply DB --remote
--
-- Existing Refresheet auth uses users.user_id TEXT.
-- Do not change the users primary key shape.

CREATE UNIQUE INDEX IF NOT EXISTS idx_user_profiles_nickname_unique
ON user_profiles(nickname)
WHERE nickname IS NOT NULL AND nickname != '';

CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT NOT NULL,
  parent_comment_id INTEGER,
  body TEXT NOT NULL,
  is_deleted INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (parent_comment_id) REFERENCES comments(id)
);

CREATE INDEX IF NOT EXISTS idx_comments_parent
ON comments(parent_comment_id);

CREATE INDEX IF NOT EXISTS idx_comments_user_created
ON comments(user_id, created_at);

CREATE TABLE IF NOT EXISTS comment_likes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_id INTEGER NOT NULL,
  user_id TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (comment_id) REFERENCES comments(id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  UNIQUE(comment_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_comment_likes_comment
ON comment_likes(comment_id);

CREATE TABLE IF NOT EXISTS operator_feedback (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT NOT NULL,
  body TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE INDEX IF NOT EXISTS idx_operator_feedback_user_created
ON operator_feedback(user_id, created_at);
