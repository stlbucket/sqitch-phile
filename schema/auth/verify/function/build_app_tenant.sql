-- Verify auth:function/build_app_tenant on pg

BEGIN;

SELECT has_function_privilege('auth.build_app_tenant(text, text)', 'execute');

ROLLBACK;
