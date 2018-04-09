# sqitch-phile #

<p>
  boilerplate schemas to support quick implementation 
  of <a href="https://www.graphile.org/postgraphile/">postgraphile</a> projects
  using <a href="http://sqitch.org/">sqitch</a> to manage migrations
</p>

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
  

## usage ##
clone the repo:  
```$xslt
git clone https://github.com/stlbucket/sqitch-phile.git
```

get on in there:
```$xslt
cd sqitch-phile
```
create a database:
```$xslt
createdb phile
```
configure your environment:
```$xslt
configure your env
```
deploy
```$xslt
./deploy.sh
```
revert
```$xslt
./revert.sh
```