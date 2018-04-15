const expect = require('chai').expect
const clog = require('fbkt-clog')
const apolloClient = require('../../apolloClient')

describe('apollo client', function(done){
  it('should connect to the server', function(done){
    process.env.USERNAME = 'appsuperadmin'
    process.env.PASSWORD = 'badpassword'

    apolloClient()
      .then(client => {
        clog('CLIENT ', client)
        expect(client).to.be.an('object')
        done()
      })
      .catch(error => {
        done(error)
      })
  })
})

