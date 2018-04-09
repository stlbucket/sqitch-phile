  DROP OWNED BY app_anonymous;
  DROP ROLE app_anonymous;

  REASSIGN OWNED BY app_user TO postgres;
  DROP OWNED BY app_user;
  DROP ROLE app_user;

  DROP OWNED BY app_demon;
  DROP ROLE app_demon;

  DROP OWNED BY app_admin;
  DROP ROLE app_admin;

  DROP OWNED BY app_super_admin;
  DROP ROLE app_super_admin;



