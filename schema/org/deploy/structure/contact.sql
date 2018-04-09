-- Deploy org:structure/contact to pg
-- requires: structure/organization

BEGIN;

  CREATE TABLE org.contact (
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL DEFAULT current_timestamp,
    organization_id uuid NOT NULL,
    location_id uuid NOT NULL,
    app_user_id uuid NULL,
    first_name text,
    last_name text,
    email text,
    CONSTRAINT pk_contact PRIMARY KEY (id)
  );
  --||--
  GRANT select, update, delete ON TABLE org.contact TO app_user, app_anonymous;
  --||--
  ALTER TABLE org.contact ADD CONSTRAINT fk_contact_organization FOREIGN KEY ( organization_id ) REFERENCES org.organization( id );
  --||--
  ALTER TABLE org.contact ADD CONSTRAINT fk_contact_location FOREIGN KEY ( location_id ) REFERENCES org.location( id );
  --||--
  ALTER TABLE org.contact ADD CONSTRAINT fk_contact_app_user FOREIGN KEY ( app_user_id ) REFERENCES auth.app_user( id );

COMMIT;
