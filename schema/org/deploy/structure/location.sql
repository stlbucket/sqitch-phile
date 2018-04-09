-- Deploy org:structure/location to pg
-- requires: structure/schema

BEGIN;

CREATE TABLE org.location (
  id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL,
  created_by_location_id uuid NOT NULL,
  name text,
  address1 text,
  address2 text,
  city text,
  state text,
  zip text,
  lat text,
  lon text,
  CONSTRAINT pk_location PRIMARY KEY (id)
);

COMMIT;
