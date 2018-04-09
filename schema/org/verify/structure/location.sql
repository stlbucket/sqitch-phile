-- Verify org:structure/location on pg

BEGIN;

SELECT
  id,
  created_at,
  updated_at,
  created_by_location_id,
  name,
  address1,
  address2,
  city,
  state,
  zip,
  lat,
  lon
  FROM org.location
 WHERE FALSE;

ROLLBACK;
