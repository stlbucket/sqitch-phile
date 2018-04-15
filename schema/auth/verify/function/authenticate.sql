-- Verify auth:function/authenticate on pg

BEGIN;

SELECT has_function_privilege('auth.authenticate(text, text)', 'execute');

ROLLBACK;
