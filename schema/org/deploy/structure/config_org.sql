-- Deploy org:structure/config_org to pg
-- requires: structure/schema

BEGIN;

CREATE TABLE auth.config_org (
  id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
  key text,
  value text,
  CONSTRAINT pk_config_org PRIMARY KEY (id)
);

COMMIT;
