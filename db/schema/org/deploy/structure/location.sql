-- Deploy org:structure/location to pg
-- requires: structure/schema

BEGIN;

  CREATE TABLE org.location (
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
    app_tenant_id uuid NOT NULL,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL,
    external_id text,
    name text,
    address1 text,
    address2 text,
    city text,
    state text,
    zip text,
    lat text,
    lon text,
    CONSTRAINT uq_location_app_tenant_and_external_id UNIQUE (app_tenant_id, external_id),
    CONSTRAINT pk_location PRIMARY KEY (id)
  );
  --||--
  ALTER TABLE org.location ADD CONSTRAINT fk_location_app_tenant FOREIGN KEY ( app_tenant_id ) REFERENCES auth.app_tenant( id );

  --||--
  CREATE FUNCTION org.fn_timestamp_update_location() RETURNS trigger AS $$
  BEGIN
    NEW.updated_at = current_timestamp;
    RETURN NEW;
  END; $$ LANGUAGE plpgsql;
  --||--
  CREATE TRIGGER tg_timestamp_update_location
    BEFORE INSERT OR UPDATE ON org.location
    FOR EACH ROW
    EXECUTE PROCEDURE org.fn_timestamp_update_location();
  --||--


  --||--
  GRANT select ON TABLE org.location TO app_user;
  --||--
  alter table org.location enable row level security;
  --||--
  create policy select_location on org.location for select
    using (auth_fn.app_user_has_access(app_tenant_id) = true);

COMMIT;
