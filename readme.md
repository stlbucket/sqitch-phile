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
  

## quick usage ##
### install <a href="http://sqitch.org/">sqitch</a> ###

### install <a href="https://www.graphile.org/postgraphile/">postgraphile</a> ###
```$xslt
npm install -g postgraphile
```

### clone the repo ###
```$xslt
git clone https://github.com/stlbucket/sqitch-phile.git
```
### git on in there ###
```$xslt
cd sqitch-phile
```
### clean out the .git dir ###
```$xslt
rm -rf .git
```
### init your git ###
```$xslt
git init
git add .
git commit -am 'init commit'
```
### create a database ###
```$xslt
createdb [your_db_name]
```
### configure your environment ###
```$xslt
cp cmd.config.example cmd.config
```
... then set your database name in cmd.config ...
```$xslt
#!/usr/bin/env bash
database="[YOUR DATABASE NAME]"
hostname="localhost"

packages=(
  schema/app-roles
  schema/auth
  schema/auth_fn
  schema/org
  schema/org_fn
  core-data
)
```
... then let sqitch-phile configure all your packages ...
```$xslt
./cmd/configure
```
### deploy ###
```$xslt
./cmd/deploy
```
### revert ###
```$xslt
./cmd/revert
```
### verify ###
```$xslt
./cmd/verify
```

work on your schemas individually the <a href="https://metacpan.org/pod/sqitchtutorial">sqitch way</a>

when you're ready to release, tag it:
```$xslt
./cmd/tag [tag-name] -n '[tag-message]'
```

assuming you've got postgraphile installed globally:
```$xslt
./cmd/server
```

