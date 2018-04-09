# sqitch-phile #

<p>
  boilerplate schemas to support quick implementation 
  of <a href="https://www.graphile.org/postgraphile/">postgraphile</a> projects
  using <a href="http://sqitch.org/">sqitch</a> to manage db scripts
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
install <a href="http://sqitch.org/">sqitch</a>

install <a href="https://www.graphile.org/postgraphile/">postgraphile</a>

clone the repo:  
```$xslt
git clone https://github.com/stlbucket/sqitch-phile.git
```
git on in there:
```$xslt
cd sqitch-phile
```
clean out the .git dir:
```$xslt
rm -rf .git
```
create a database:
```$xslt
createdb [your_db_name]
```
configure your environment:
```$xslt
./cmd/init.sh
./cmd/target.sh [your_db_name] db:pg:[your_db_name]
./cmd/engine.sh [your_db_name]
```
deploy:
```$xslt
./cmd/deploy.sh
```
revert:
```$xslt
./cmd/revert.sh
```
verify:
```$xslt
./cmd/verify.sh
```

work on your schemas the sqitch way

when you're ready to release, tag it:
```$xslt
./cmd/tag.sh [tag-name] -n '[tag-message]'
```