-- Deploy org:function/build_organization to pg
-- requires: structure/organization

BEGIN;

create function org.build_tenant_organization(
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
  _app_user := (SELECT auth.current_app_user());

  _app_tenant := (
    SELECT auth.build_app_tenant(
      _name
      ,_identifier
    )
  );

  _app_user := (
    SELECT auth.build_app_user(
      _app_tenant.id
      ,_primary_contact_email
      ,'badpassword'
      ,'Admin'
    )
  );

  _organization := org.build_organization(
    _name
    ,_identifier
    ,_app_tenant.id
  );

  UPDATE org.organization
  SET this_app_tenant_id = _app_tenant.id
  WHERE id = _organization.id
  RETURNING *
  INTO _organization
  ;

  _primary_contact := org.build_contact(
    _primary_contact_first_name
    ,_primary_contact_last_name
    ,_primary_contact_email
    ,_organization.id
  );

--  RAISE EXCEPTION '
--  wtf:
--  app_tenant: %
--
--  app_user: %
--
--  _primary_contact: %
--
--  _organization: %
--  '
--  , _app_tenant
--  , _app_user
--  , _primary_contact
--  , _organization
--  ;

  RETURN _organization;

end;
$$ language plpgsql strict security definer;

GRANT EXECUTE ON FUNCTION org.build_tenant_organization(
  text
  ,text
  ,text
  ,text
  ,text
) TO app_super_admin;

COMMIT;
