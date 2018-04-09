# sqitch-phile #

boilerplate schemas to support quick implementation of <a href="https://www.graphile.org/postgraphile/">postgraphile</a> projects

basic packages include:
- app-roles: 
  - creates db roles to support postgres rls security
- auth: 
  - app_user management and login support.  
  - this version supports the basic auth described in the postgraphile docs.
  - support for oauth or other strategies may be added here or in an alternate schema flavor
  - requires app-roles
- org: 
  - generic organization/location/contact support.
  - org.contact ==> auth.app_user
  - requires auth
  
  
scripts/deploy.sh:

```$xslt
#!/usr/bin/env bash

(cd ./schema/app-roles/ && sqitch deploy $1)
(cd ./schema/auth/ && sqitch deploy $1)
(cd ./schema/org/ && sqitch deploy $1)
```


is this a good way to manage multiple schemas with sqitch?

is there a better way to manage multiple 'sqitchlets' together at one time directly with sqitch.conf files?