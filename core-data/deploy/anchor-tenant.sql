-- Deploy auth:anchor-tenent to pg

BEGIN;

  SELECT auth.build_app_tenant(
    'Anchor Tenant'
    ,'T000001'
  )
  ;

  SELECT auth.build_app_user(
    (SELECT id FROM auth.app_tenant WHERE identifier = 'T000001')
    ,'appsuperadmin'
    ,'badpassword'
    ,'SuperAdmin'
  )
  ;

COMMIT;
