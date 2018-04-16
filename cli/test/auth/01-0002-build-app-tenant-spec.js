const expect = require('chai').expect
const clog = require('fbkt-clog')
const apolloClient = require('../../apolloClient')
const buildAppTenant = require('../../gql/mutation/buildAppTenant')

describe('auth', function(done){
  it('should build a new app tenant', function(done){
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'appsuperadmin',
      password: 'badpassword'
    })

    buildAppTenant({
      name: 'Test'
      ,identifier: 'Test'
    })
      .then(appTenant => {
        clog('appTenant', appTenant)
        expect(appTenant).to.be.an('object')
        expect(appTenant.name).to.equal('Test')
        expect(appTenant.identifier).to.equal('Test')
        done()
      })
      .catch(error => {
        done(error)
      })
  })
})

