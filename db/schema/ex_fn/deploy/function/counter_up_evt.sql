-- Deploy ex_fn:function/counter_up_evt to pg
-- requires: structure/schema

BEGIN;

  CREATE function ex_fn.counter_up_evt() returns ex.counter_evt AS $$
  DECLARE
    _app_user auth.app_user;
    _evt evt.evt;
    _counter_evt ex.counter_evt;
  BEGIN
    _app_user := auth_fn.current_app_user();

    INSERT INTO evt.evt(
      app_tenant_id
      ,created_by_app_user_id
      ,name
      ,params
      ,result
    )
    SELECT
      _app_user.app_tenant_id
      ,_app_user.id
      ,'counter_up_evt'
      ,'{}'
      ,'Captured'
    RETURNING *
    INTO _evt;

    _counter_evt := ex_fn.consume_counter_up_evt(_evt.id);

    RETURN _counter_evt;
  END;
  $$ language plpgsql strict security definer;
  --||--
  comment on function ex_fn.counter_up_evt() is 'Capture counter event and process it.';
  --||--
  GRANT execute ON FUNCTION ex_fn.counter_up_evt() TO app_user;


  CREATE function ex_fn.consume_counter_up_evt(
    _evt_id uuid
  ) returns ex.counter_evt AS $$
  DECLARE
    _app_user auth.app_user;
    _evt evt.evt;
    _counter_evt ex.counter_evt;
  BEGIN
    SELECT *
    INTO _evt
    FROM evt.evt
    WHERE id = _evt_id;

    SELECT *
    INTO _app_user
    FROM auth.app_user
    WHERE id = _evt.created_by_app_user_id;

    IF _evt.result = 'Captured' THEN

      UPDATE ex.counter_evt
      SET current_value = current_value + 1
      WHERE app_tenant_id = _app_user.app_tenant_id
      RETURNING *
      INTO _counter_evt;

      UPDATE evt.evt
      SET result = 'Consumed'
      WHERE id = _evt.id;

    END IF;

    RETURN _counter_evt;
  END;
  $$ language plpgsql strict security definer;
  --||--
  comment on function ex_fn.counter_up_evt() is 'Increase app_tenant_token by 1.';
  --||--
  GRANT execute ON FUNCTION ex_fn.consume_counter_up_evt(uuid) TO app_user;


  CREATE function ex_fn.rollback_counter_up_evt(
    _evt_id uuid
  ) returns ex.counter_evt AS $$
  DECLARE
    _app_user auth.app_user;
    _evt evt.evt;
    _counter_evt ex.counter_evt;
  BEGIN
    SELECT *
    INTO _evt
    FROM evt.evt
    WHERE id = _evt_id;

    SELECT *
    INTO _app_user
    FROM auth.app_user
    WHERE id = _evt.created_by_app_user_id;

    IF _evt.result = 'Consumed' THEN

      UPDATE ex.counter_evt
      SET current_value = current_value - 1
      WHERE app_tenant_id = _app_user.app_tenant_id
      RETURNING *
      INTO _counter_evt;

      UPDATE evt.evt
      SET result = 'Captured'
      WHERE id = _evt.id;

    END IF;

    RETURN _counter_evt;
  END;
  $$ language plpgsql strict security definer;
  --||--
  comment on function ex_fn.counter_up_evt() is 'UNDO: Increase app_tenant_token by 1.';
  --||--
  GRANT execute ON FUNCTION ex_fn.rollback_counter_up_evt(uuid) TO app_user;


COMMIT;
