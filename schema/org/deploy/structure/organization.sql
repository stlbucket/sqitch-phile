-- Deploy org:structure/organization to pg
-- requires: structure/location

BEGIN;

  CREATE TABLE org.organization (
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL DEFAULT current_timestamp,
    created_by_organization_id uuid NOT NULL,
    name text,
    location_id uuid NULL,
    CONSTRAINT pk_organization PRIMARY KEY (id)
  );
  --||--
  GRANT select, update, delete ON TABLE org.organization TO app_user, app_anonymous;
  --||--
  ALTER TABLE org.organization ADD CONSTRAINT fk_organization_location FOREIGN KEY ( location_id ) REFERENCES org.location( id );

COMMIT;
