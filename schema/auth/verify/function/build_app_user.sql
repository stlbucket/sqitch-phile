-- Verify auth:function/build_app_user on pg

BEGIN;

SELECT has_function_privilege('auth.build_app_user(uuid, text, text, auth.permission_key)', 'execute');

ROLLBACK;
