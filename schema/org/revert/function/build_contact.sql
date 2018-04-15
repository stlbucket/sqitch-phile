-- Revert org:function/build_contact from pg

BEGIN;

  DROP FUNCTION IF EXISTS org.build_contact(
    text
    ,text
    ,text
    ,uuid
    ,uuid
  );

COMMIT;
