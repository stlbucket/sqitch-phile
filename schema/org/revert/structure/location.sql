-- Revert org:structure/location from pg

BEGIN;

DROP TABLE IF EXISTS org.location CASCADE;

COMMIT;
