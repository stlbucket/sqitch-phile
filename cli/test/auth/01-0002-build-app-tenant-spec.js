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
        done()
      })
      .catch(error => {
        done(error)
      })
  })
})

