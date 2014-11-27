process.env.NODE_ENV = 'test'
mongoose = require 'mongoose'
User = require '../app/model/user'
chai = require('chai')
expect = chai.expect
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

  it 'does not validate when there is no username', (done) ->
    user = new User {username: "user" }
    user.validate (error) ->
      check done, ->
        expect(error.name).to.eql "ValidationError"

  it 'does not save when there is no password', (done) ->
    user = new User {password: "pisswird"}
    user.validate (error) ->
      check done, ->
        expect(error.name).to.eql "ValidationError"

  it 'saves users', (done) ->
    user = new User {username: "bob", password: "pisswird"}
    #Leaving the full method below in place as an example
    user.save (error, saved_user) ->
      try
        expect( saved_user.username ).to.eql "bob"
        done()
      catch error
        done(error)

  it 'cannot have two users with the same username', (done) ->
    user = new User {username: "bob", password: "rogolo"}
    user.validate (error) ->
      check done, ->
        expect(error.name).to.eql "ValidationError"

  it 'hashes the password of a user', (done) ->
    user = new User {username: "derek", password: "12345678"}
    user.save (save_error, saved_user) ->
      User.find {username: "derek"}, (error, result)->
        check done, ->
          expect(result[0].password).to.not.eql "12345678"

  it 'validates the password of a valid user', (done) ->
    user = new User {username: "yvette", password: "12345678"}
    user.save (error) ->
      done(error) if error
      User.validatePassword "yvette", "12345678", (error, result)->
        check done, ->
          expect(result).to.equal true

