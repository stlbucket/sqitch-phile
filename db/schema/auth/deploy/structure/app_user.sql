-- Deploy auth:structure/app_user to pg
-- requires: custom-type/permission-key

BEGIN;

  CREATE TABLE auth.app_user (
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
    app_tenant_id uuid NOT NULL,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL,
    username text UNIQUE NOT NULL,
    password_hash text NOT NULL,
    inactive boolean NOT NULL DEFAULT false,
    password_reset_required boolean NOT NULL DEFAULT false,
    permission_key auth.permission_key NOT NULL,
    CONSTRAINT pk_app_user PRIMARY KEY (id)
  );
  --||--
  ALTER TABLE auth.app_user ADD CONSTRAINT fk_app_user_app_tenant FOREIGN KEY ( app_tenant_id ) REFERENCES auth.app_tenant( id );

  --||--
  GRANT select ON TABLE auth.app_user TO app_super_admin;

  --||--
  CREATE FUNCTION auth.fn_timestamp_update_app_user() RETURNS trigger AS $$
  BEGIN
    NEW.updated_at = current_timestamp;
    RETURN NEW;
  END; $$ LANGUAGE plpgsql;
  --||--
  CREATE TRIGGER tg_timestamp_update_app_user
    BEFORE INSERT OR UPDATE ON auth.app_user
    FOR EACH ROW
    EXECUTE PROCEDURE auth.fn_timestamp_update_app_user();
  --||--

COMMIT;
