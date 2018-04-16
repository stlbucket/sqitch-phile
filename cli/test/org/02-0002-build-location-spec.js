const expect = require('chai').expect
const clog = require('fbkt-clog')
const apolloClient = require('../../apolloClient')
const buildAppTenant = require('../../gql/mutation/buildAppTenantOrganization')
const allOrganizations = require('../../gql/query/allOrganizations')

describe('org', function(done){
  it('should build a location', function(done){
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'appsuperadmin',
      password: 'badpassword'
    })

    buildAppTenant({
      name: 'Test Tenant Org'
      ,identifier: 'TestTenantOrg'
      ,primaryContactFirstName: 'test'
      ,primaryContactLastName: 'tester'
      ,primaryContactEmail: 'testy.mctesterson@testyorg.org'
    })
      .then(organization => {
        expect(organization).to.be.an('object')
        expect(organization.name).to.equal('Test Tenant Org')

        apolloClient.setCredentials({
          username: 'testy.mctesterson@testyorg.org',
          password: 'badpassword'
        })

        return apolloClient.connect()
      })
      .then(client => {
        expect(client).to.be.an('object')
        return allOrganizations()
      })
      .then(organizations => {
        expect(organizations.length).to.equal(1)
        expect(organizations[0].name).to.equal('Test Tenant Org')
        done()
      })
      .catch(error => {
        done(error)
      })
  })

})

