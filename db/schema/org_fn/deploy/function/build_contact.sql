-- Deploy org:function/build_contact to pg
-- requires: structure/contact

BEGIN;

  create function org_fn.build_contact(
    _first_name text
    ,_last_name text
    ,_email text
    ,_organization_id uuid
  )
  returns org.contact as $$
  declare
    _app_user auth.app_user;
    _contact org.contact;
    _organization org.organization;
  begin
    _app_user := (SELECT auth_fn.current_app_user());

    SELECT *
    INTO _organization
    FROM org.organization
    WHERE id = _organization_id;

    IF _organization.id IS NULL THEN
      RAISE EXCEPTION 'No organization exists for id: %', _organization_id;
    END IF;

    INSERT INTO org.contact(
      first_name
      ,last_name
      ,email
      ,organization_id
      ,app_tenant_id
    )
    SELECT
      _first_name
      ,_last_name
      ,_email
      ,_organization_id
      ,_organization.app_tenant_id
    RETURNING *
    INTO _contact;

    RETURN _contact;

  end;
  $$ language plpgsql strict security definer;

  GRANT EXECUTE ON FUNCTION org_fn.build_contact(
    text
    ,text
    ,text
    ,uuid
  ) TO app_user;

COMMIT;
