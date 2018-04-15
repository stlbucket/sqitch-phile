-- Verify org:function/build_organization on pg

BEGIN;

SELECT has_function_privilege('
  org.build_organization(
  text
  ,text
  ,uuid
  )
', 'execute');

ROLLBACK;
