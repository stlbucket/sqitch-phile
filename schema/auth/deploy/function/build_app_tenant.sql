-- Deploy auth:function/build_app_tenant to pg
-- requires: structure/schema

BEGIN;

  CREATE function auth.build_app_tenant(
    _name text,
    _identifier text
  ) returns auth.app_tenant AS $$
  DECLARE
    _app_tenant auth.app_tenant;
  BEGIN

    SELECT *
    INTO _app_tenant
    FROM auth.app_tenant
    WHERE name = _name
    AND identifier = _identifier;

    IF _app_tenant.id IS NULL THEN
      INSERT INTO auth.app_tenant(
        name
        ,identifier
      )
      SELECT
        _name
        ,_identifier
      RETURNING *
      INTO _app_tenant
      ;
    END IF;

    RETURN _app_tenant;
  end;
  $$ language plpgsql strict security definer;
  --||--
  comment on function auth.build_app_tenant(
    text,
    text
  ) is 'Creates a new app user';
  --||--
  GRANT execute ON FUNCTION auth.build_app_tenant(
    text,
    text
  ) TO app_super_admin;

COMMIT;
