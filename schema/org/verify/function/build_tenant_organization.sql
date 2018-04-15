-- Deploy org:function/build_organization to pg
-- requires: structure/organization

BEGIN;

SELECT has_function_privilege('
  org.build_tenant_organization(
    text
    ,text
    ,text
    ,text
    ,text
  )
', 'execute');

COMMIT;
