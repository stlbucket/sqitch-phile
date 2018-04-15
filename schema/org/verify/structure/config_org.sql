-- Verify org:structure/config_org on pg

BEGIN;

  SELECT
    id,
    key,
    value
  FROM auth.config_org
  WHERE FALSE;

ROLLBACK;
