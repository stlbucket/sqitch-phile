-- Deploy app-roles:roles to pg

BEGIN;

  CREATE ROLE app_super_admin;
  CREATE ROLE app_admin;
  CREATE ROLE app_demon;
  CREATE ROLE app_user;
  CREATE ROLE app_anonymous;


COMMIT;
