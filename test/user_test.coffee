process.env.NODE_ENV = 'test'
expect = require('chai').expect
mongoose = require 'mongoose'
User = require '../app/model/user'

describe 'User', ->

  beforeEach (done) ->
    mongoose.connect 'mongodb://localhost/chitter-test', done

  afterEach (done) ->
    mongoose.connection.db.executeDbCommand { dropDatabase:1  }, (err, result) ->
      mongoose.connection.close done

  it 'starts with no users', ->
    User.find {}, (error, users)->
      expect(users).to.eq []
      done

  it 'can add a new user', ->
    User.create {username: "bob", password: "pisswird"}, (error, user) ->
      User.find {}, (error, users) ->
        console.log(users.length)
        expect(users.length).to.be 1
        done

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
