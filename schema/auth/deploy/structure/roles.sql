-- Deploy auth:structure/roles to pg

BEGIN;
  CREATE ROLE fbkt_super_admin;
  CREATE ROLE fbkt_admin;
  CREATE ROLE fbkt_sync;
  CREATE ROLE fbkt_user;
  CREATE ROLE fbkt_anonymous;
COMMIT;
