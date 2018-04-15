-- Deploy org:structure/contact to pg
-- requires: structure/organization

BEGIN;

  CREATE TABLE org.contact (
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
    app_tenant_id uuid NOT NULL,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL,
    organization_id uuid NULL,
    location_id uuid NULL,
    app_user_id uuid NULL,
    external_id text,
    first_name text,
    last_name text,
    email text,
    CONSTRAINT pk_contact PRIMARY KEY (id)
  );
  --||--
  GRANT select ON TABLE org.contact TO app_user;
  --||--
  ALTER TABLE org.contact ADD CONSTRAINT fk_contact_organization FOREIGN KEY ( organization_id ) REFERENCES org.organization( id );
  --||--
  ALTER TABLE org.contact ADD CONSTRAINT fk_contact_location FOREIGN KEY ( location_id ) REFERENCES org.location( id );
  --||--
  ALTER TABLE org.contact ADD CONSTRAINT fk_contact_app_user FOREIGN KEY ( app_user_id ) REFERENCES auth.app_user( id );
  --||--
  ALTER TABLE org.contact ADD CONSTRAINT fk_contact_app_tenant FOREIGN KEY ( app_tenant_id ) REFERENCES auth.app_tenant( id );

  --||--
  CREATE FUNCTION org.fn_timestamp_update_contact() RETURNS trigger AS $$
  BEGIN
    NEW.updated_at = current_timestamp;
    RETURN NEW;
  END; $$ LANGUAGE plpgsql;
  --||--
  CREATE TRIGGER tg_timestamp_update_contact
    BEFORE INSERT OR UPDATE ON org.contact
    FOR EACH ROW
    EXECUTE PROCEDURE org.fn_timestamp_update_contact();
  --||--

COMMIT;
