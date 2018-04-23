-- Revert ex:function/counter_up from pg

BEGIN;

  DROP FUNCTION IF EXISTS ex.counter_up();

COMMIT;
