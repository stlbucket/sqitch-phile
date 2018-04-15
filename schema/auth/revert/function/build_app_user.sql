-- Revert auth:function/build_app_user from pg

BEGIN;

  DROP FUNCTION IF EXISTS auth.build_app_user(
    uuid,
    text,
    text,
    auth.permission_key
  );

COMMIT;
