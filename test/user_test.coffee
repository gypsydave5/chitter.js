process.env.NODE_ENV = 'test'
mongoose = require 'mongoose'
User = require '../app/model/user'
#require 'mocha-mongoose'
chai = require('chai')
expect = chai.expect
should = chai.should
dbURI = 'mongodb://localhost/chitter-test'

describe 'The User model', ->

  before (done) ->
    mongoose.connect dbURI, ->
      done()

  check = (done, expectation)->
    try
      expectation()
      done()
    catch error
      done error

  it 'starts with no users', ->
    User.count {}, (error, count)->
      check done, ->
        expect(count).to.eql 0

  it 'does not save when there is no username', (done) ->
    user = new User {username: "user" }
    user.save (error, saved_user) ->
      User.count({}, (error,count)->
        check done, ->
          expect(count).to.eql 0
      )

  it 'does not save when there is no password', (done) ->
    user = new User {password: "pisswird"}
    user.save (save_error, saved_user) ->
      User.count({}, (error,count)->
        check done, ->
          expect(save_error.message).to.eql "Validation failed"
          expect(count).to.eql 0
      )

  it 'saves users', (done) ->
    user = new User {username: "bob", password: "pisswird"}
    user.save (error, saved_user) ->
      try
        expect( saved_user.username ).to.eql "bob"
        done()
      catch error
        done(error)

  it 'cannot have two users with the same username', (done) ->
    user = new User {username: "bob", password: "rogolo"}
    user.save (save_error, saved_user) ->
      User.count {}, (error, count)->
        check done, ->
          expect(save_error.errors.username.message).to.eql "Error, expected `username` to be unique. Value: `bob`"
          expect(count).to.eql 1

  it 'hashes the password of a user', (done) ->
    user = new User {username: "derek", password: "12345678"}
    user.save (save_error, saved_user) ->
      User.find {username: "derek"}, (error, result)->
        check done, ->
          expect(result[0].password).to.not.eql "12345678"




    #user.new_user "erik", "paaassssword", done()
    #user.new_user "Dave", "password", done()

    #user.count {}, (error, count) ->
      #expect(count).to.eql 1

    #expect(user.count( {}, (e,c) ->
      #done()
    #)).to.eql 1

    #user.count( {}, (e,c)->
      #expect(c).to.eql 2
      #done()
    #)


    #expect(user.new_user "erik", "thedog", ->
      #user.new_user "erik", "bobobob", ->
        #user.count {}, (error, count)->
          #done(count)
    #).to.eql 1

  #it 'can add a new user', ->
    #user.create {username: "bob", password: "pisswird"}, ->
      #user.find({}, (error, users)->
        #console.log(users)
        #lenny = users.length
        #console.log(lenny)
      #)

  #it 'can add a two new users', ->
    #User.create {username: "bob", password: "pisswird"}, ->
      #User.create {username: "harry", password: "pisswird"}, ->
        #User.find {}, (error, users)->
          #expect(users.length).to.be 1
          #console.log(users)

  #it 'must have a username', ->
    #user = new User {password: "pisswird"}
    #user.save (error, user)->
      #should.exist(error)
      #expect(error.message).to.eq ""

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
