const clog = require('fbkt-clog')
const buildAppTenant = require('../../gql/mutation/buildAppTenantOrganization')


describe('org', function(done){
  it('should build a new app tenant organization', function(done){
    process.env.USERNAME = 'appsuperadmin'
    process.env.PASSWORD = 'badpassword'

    buildAppTenant({
      name: 'Test Tenant Org'
      ,identifier: 'TestTenantOrg'
      ,primaryContactFirstName: 'test'
      ,primaryContactLastName: 'tester'
      ,primaryContactEmail: 'testy.mctesterson@testyorg.org'
    })
      .then(organization => {
        clog('organization', organization)
        done()
      })
      .catch(error => {
        done(error)
      })
  })
})

