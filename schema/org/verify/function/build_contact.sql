-- Verify org:function/build_contact on pg

BEGIN;

SELECT has_function_privilege('
  org.build_contact(
    text
    ,text
    ,text
    ,uuid
  )
', 'execute');

ROLLBACK;
