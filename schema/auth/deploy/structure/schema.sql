-- Deploy auth:structure/schema to pg
-- requires: structure/roles

BEGIN;

  CREATE SCHEMA auth;
  
  GRANT usage ON SCHEMA auth TO fbkt_user;
  
  ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;

COMMIT;
