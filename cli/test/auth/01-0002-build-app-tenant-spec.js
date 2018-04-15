const expect = require('chai').expect
const clog = require('fbkt-clog')
const buildAppTenant = require('../../gql/mutation/buildAppTenant')

describe('auth', function(done){
  it('should build a new app tenant', function(done){
    process.env.USERNAME = 'appsuperadmin'
    process.env.PASSWORD = 'badpassword'

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

