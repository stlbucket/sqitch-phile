-- Revert org-fn:function/set_contact_location from pg

BEGIN;

  DROP FUNCTION IF EXISTS org_fn.set_contact_location(
    uuid
    ,uuid
  );

COMMIT;
