-- Deploy auth:structure/app_user to pg
-- requires: custom-type/permission-key

BEGIN;

CREATE TABLE auth.app_user (
  id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp,
  username text UNIQUE NOT NULL,
  password_hash text NOT NULL,
  active boolean NOT NULL DEFAULT false,
  CONSTRAINT pk_app_user PRIMARY KEY (id)
);

COMMIT;
