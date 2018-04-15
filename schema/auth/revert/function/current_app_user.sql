-- Revert auth:function/current_app_user from pg

BEGIN;

  DROP FUNCTION IF EXISTS auth.current_app_user();

COMMIT;
