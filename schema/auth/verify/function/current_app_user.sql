-- Verify auth:function/current_app_user on pg

BEGIN;

SELECT has_function_privilege('auth.current_app_user()', 'execute');

ROLLBACK;
