-- Revert auth:function/build_app_tenant from pg

BEGIN;

  DROP FUNCTION IF EXISTS auth.build_app_tenant(
    text
    ,text
  );

COMMIT;
