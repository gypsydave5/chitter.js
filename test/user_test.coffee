process.env.NODE_ENV = 'test'
expect = require('chai').expect
#user = require '../app/model/user'

describe 'User', ->

  it 'increases the user count by one when a user is created', ->
    user.new
    expect(user.count).to.eq 1
