-- Revert org:structure/contact from pg

BEGIN;

DROP TABLE IF EXISTS org.contact CASCADE;

COMMIT;
