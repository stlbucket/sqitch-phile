-- Revert org:function/current_app_user_contact from pg

BEGIN;

  DROP FUNCTION IF EXISTS org.current_app_user_contact();

COMMIT;
