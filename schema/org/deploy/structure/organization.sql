-- Deploy org:structure/organization to pg
-- requires: structure/location

BEGIN;

  CREATE TABLE org.organization (
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
    this_app_tenant_id uuid NULL UNIQUE,
    app_tenant_id uuid NOT NULL,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL,
    external_id text,
    name text,
    location_id uuid NULL,
    CONSTRAINT pk_organization PRIMARY KEY (id)
  );
  --||--
  GRANT select ON TABLE org.organization TO app_user;
  --||--
  ALTER TABLE org.organization ADD CONSTRAINT fk_organization_location FOREIGN KEY ( location_id ) REFERENCES org.location( id );
  --||--
  ALTER TABLE org.organization ADD CONSTRAINT fk_organization_app_tenant FOREIGN KEY ( app_tenant_id ) REFERENCES auth.app_tenant( id );
  --||--
  ALTER TABLE org.organization ADD CONSTRAINT fk_organization_this_app_tenant FOREIGN KEY ( this_app_tenant_id ) REFERENCES auth.app_tenant( id );

  --||--
  CREATE FUNCTION org.fn_timestamp_update_organization() RETURNS trigger AS $$
  BEGIN
    NEW.updated_at = current_timestamp;
    RETURN NEW;
  END; $$ LANGUAGE plpgsql;
  --||--
  CREATE TRIGGER tg_timestamp_update_organization
    BEFORE INSERT OR UPDATE ON org.organization
    FOR EACH ROW
    EXECUTE PROCEDURE org.fn_timestamp_update_organization();
  --||--

COMMIT;
