-- Deploy org:function/build_organization to pg
-- requires: structure/organization

BEGIN;

create function org_fn.build_tenant_organization(
  _name text
  ,_identifier text
  ,_primary_contact_email text
  ,_primary_contact_first_name text
  ,_primary_contact_last_name text
)
returns org.organization as $$
declare
  _app_tenant auth.app_tenant;
  _app_user auth.app_user;
  _organization org.organization;
  _primary_contact org.contact;
begin
  _app_user := (SELECT auth_fn.current_app_user());

  _app_tenant := (
    SELECT auth_fn.build_app_tenant(
      _name
      ,_identifier
    )
  );

  SELECT *
  INTO _app_user
  FROM auth.app_user
  WHERE app_tenant_id = _app_tenant.id
  AND username = _primary_contact_email
  ;

  IF _app_user.id IS NULL THEN
    _app_user := (
      SELECT auth_fn.build_app_user(
        _app_tenant.id
        ,_primary_contact_email
        ,'badpassword'
        ,'Admin'
      )
    );
  END IF;

  _organization := org_fn.build_organization(
    _name
    ,_identifier
  );

  UPDATE org.organization
  SET this_app_tenant_id = _app_tenant.id
  WHERE id = _organization.id
  RETURNING *
  INTO _organization
  ;

  _primary_contact := org_fn.build_contact(
    _primary_contact_first_name
    ,_primary_contact_last_name
    ,_primary_contact_email
    ,_organization.id
  );

  RETURN _organization;

end;
$$ language plpgsql strict security definer;

GRANT EXECUTE ON FUNCTION org_fn.build_tenant_organization(
  text
  ,text
  ,text
  ,text
  ,text
) TO app_super_admin;

COMMIT;
