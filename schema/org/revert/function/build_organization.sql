-- Revert org:function/build_organization from pg

BEGIN;

  DROP FUNCTION IF EXISTS org.build_organization(
    text
    ,text
    ,uuid
  );

COMMIT;
