-- Deploy org:function/build_organization to pg
-- requires: structure/organization

BEGIN;

create function org.build_organization(
  _name text,
  _external_id text,
  _id uuid default null
)
returns org.organization as $$
declare
  _app_user auth.app_user;
  _organization org.organization;
begin
  _app_user := (SELECT auth.current_app_user());

  INSERT INTO org.organization(
    name
    ,external_id
    ,app_tenant_id
  )
  SELECT
    _name
    ,_external_id
    ,_app_user.app_tenant_id
  ON CONFLICT(id)
  DO UPDATE
  SET
    name = _name
    ,external_id = _external_id
  RETURNING *
  INTO _organization
  ;

  RETURN _organization;

end;
$$ language plpgsql strict security definer;

GRANT EXECUTE ON FUNCTION org.build_organization(
  text
  ,text
  ,uuid
) TO app_user;

COMMIT;
