-- Verify auth:structure/roles on pg

BEGIN;

SELECT 1/count(*) FROM pg_roles WHERE rolname='fbkt_super_admin';
SELECT 1/count(*) FROM pg_roles WHERE rolname='fbkt_admin';
SELECT 1/count(*) FROM pg_roles WHERE rolname='fbkt_sync';
SELECT 1/count(*) FROM pg_roles WHERE rolname='fbkt_user';
SELECT 1/count(*) FROM pg_roles WHERE rolname='fbkt_anonymous';

ROLLBACK;
