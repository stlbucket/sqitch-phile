-- Verify org:function/build_location on pg

BEGIN;

SELECT has_function_privilege('
  org.build_location(
    text
   ,text
   ,text
   ,text
   ,text
   ,text
   ,text
   ,text
   ,uuid
  )
', 'execute');

ROLLBACK;
