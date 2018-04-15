-- Revert auth:function/authenticate from pg

BEGIN;

  DROP FUNCTION IF EXISTS auth.authenticate(
    text
    ,text
  );

COMMIT;
