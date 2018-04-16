select
  id
  ,name
from auth.app_tenant;

select
  id
  ,username
  ,app_tenant_id
from auth.app_user;

select
  id
  ,name
  ,app_tenant_id
  ,external_id
from org.organization;

select
  id
  ,first_name
  ,last_name
  ,email
  ,app_tenant_id
  ,app_user_id
  ,organization_id
from org.contact;