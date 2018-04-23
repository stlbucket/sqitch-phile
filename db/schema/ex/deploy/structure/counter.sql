-- Deploy ex:structure/counter to pg
-- requires: structure/schema

BEGIN;

  CREATE TABLE ex.counter (
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v1(),
    app_tenant_id uuid UNIQUE NOT NULL,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL,
    current_value integer NOT NULL DEFAULT 0,
    CONSTRAINT pk_counter PRIMARY KEY (id)
  );
  --||--
  ALTER TABLE ex.counter ADD CONSTRAINT fk_counter_app_tenant FOREIGN KEY ( app_tenant_id ) REFERENCES auth.app_tenant( id );

  --||--
  CREATE FUNCTION ex.fn_timestamp_update_counter() RETURNS trigger AS $$
  BEGIN
    NEW.updated_at = current_timestamp;
    RETURN NEW;
  END; $$ LANGUAGE plpgsql;
  --||--
  CREATE TRIGGER tg_timestamp_update_counter
    BEFORE INSERT OR UPDATE ON ex.counter
    FOR EACH ROW
    EXECUTE PROCEDURE ex.fn_timestamp_update_counter();
  --||--


  --||--
  GRANT select ON TABLE ex.counter TO app_user;

COMMIT;
