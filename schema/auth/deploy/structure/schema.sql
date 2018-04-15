-- Deploy auth:structure/schema to pg
-- requires: structure/roles

BEGIN;

  CREATE SCHEMA auth;
  
  GRANT usage ON SCHEMA auth TO app_user, app_anonymous;
  
  ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;

COMMIT;
