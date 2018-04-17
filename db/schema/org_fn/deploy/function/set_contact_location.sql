-- Deploy org:function/set_contact_location to pg
-- requires: structure/contact

BEGIN;

  create function org_fn.set_contact_location(
    _contact_id uuid
    ,_location_id uuid
  )
  returns org.contact as $$
  declare
    _app_user auth.app_user;
    _contact org.contact;
  begin
    _app_user := auth_fn.current_app_user();

    UPDATE org.contact c
    SET location_id = _location_id
    WHERE id = _contact_id
    AND auth_fn.app_user_has_access(c.app_tenant_id)
    RETURNING *
    INTO _contact
    ;

    RETURN _contact;

  end;
  $$ language plpgsql strict security definer;

  GRANT EXECUTE ON FUNCTION org_fn.set_contact_location(
    uuid
    ,uuid
  ) TO app_user;

COMMIT;
