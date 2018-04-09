-- Revert auth:structure/roles from pg

BEGIN;
  DROP OWNED BY fbkt_super_admin;
  DROP ROLE fbkt_super_admin;

  DROP OWNED BY fbkt_admin;
  DROP ROLE fbkt_admin;

  DROP OWNED BY fbkt_sync;
  DROP ROLE fbkt_sync;

  DROP OWNED BY fbkt_user;
  DROP ROLE fbkt_user;

  DROP OWNED BY fbkt_anonymous;
  DROP ROLE fbkt_anonymous;
COMMIT;
