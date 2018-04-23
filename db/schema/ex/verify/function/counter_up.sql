-- Verify ex:function/counter_up on pg

BEGIN;

  SELECT has_function_privilege('ex.counter_up()', 'execute');

ROLLBACK;
