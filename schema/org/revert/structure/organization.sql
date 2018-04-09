-- Revert org:structure/organization from pg

BEGIN;

  DROP TABLE IF EXISTS org.organization CASCADE;

COMMIT;
