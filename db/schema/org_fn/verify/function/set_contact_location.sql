-- Verify org-fn:function/set_contact_location on pg

BEGIN;

SELECT has_function_privilege('
    org_fn.set_contact_location(
      uuid
      ,uuid
    )
  ', 'execute');

ROLLBACK;
