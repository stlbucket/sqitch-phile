const expect = require('chai').expect
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
        expect(organization).to.be.an('object')
        expect(organization.name).to.equal('Test Tenant Org')
        done()
      })
      .catch(error => {
        done(error)
      })
  })
})

