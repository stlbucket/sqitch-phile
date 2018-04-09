-- Revert auth:structure/app_user from pg

BEGIN;

DROP TABLE IF EXISTS auth.app_user CASCADE;

COMMIT;
