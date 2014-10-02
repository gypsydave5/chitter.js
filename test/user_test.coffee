process.env.NODE_ENV = 'test'
expect = require('chai').expect
mongoose = require 'mongoose'
server = require('../start')
User = require '../app/model/user'

describe 'User', ->

  afterEach (done) ->
    mongoose.connection.db.executeDbCommand { dropDatabase: 1 }, done

  it 'starts with no users', ->
    User.find {}, (error, users)->
      expect(users).to.eq []

  it 'can add a new user', ->
    User.create {username: "bob", password: "pisswird"}, (error, user) ->
      User.find {}, (error, users) ->
        expect(users.length).to.be 1

      #expect(user.length).to.eq 1






  #it 'increases the user count by one when a user is created', ->
    #User.count {}, (error, count)->
      #count.should.equal 5

    #bob = new User({username: "bob", password: "passswird"})
    #bob.save

    #User.count {}, (error, count)->
      #if error
        #console.log("FAIL")

      #expect(count).to.be 5
