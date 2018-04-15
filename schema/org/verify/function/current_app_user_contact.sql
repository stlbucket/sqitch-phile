-- Verify org:function/current_app_user_contact on pg

BEGIN;

SELECT has_function_privilege('org.current_app_user_contact()', 'execute');

ROLLBACK;
