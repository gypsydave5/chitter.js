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

  it 'starts with no users', (done)->
    User.count {}, (error, count)->
      check done, ->
        expect(count).to.eql 0

  it 'does not save when there is no username', (done) ->
    user = new User {username: "user" }
    user.save (error, saved_user) ->
      User.count({}, (error, count)->
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

