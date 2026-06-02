-- Migration 015: Drop point_wallets (seed/cron compatibility remnant)
-- Prerequisite: cron.js point_wallets UPDATE removed (done in same commit).
-- Live data: 10 rows, all seed/npc virtual users only. No real user data.
-- Authoritative balance table: user_points (used by all API endpoints).

DROP TABLE IF EXISTS point_wallets;
