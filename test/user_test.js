var User, expect, mongoose, server, should;

process.env.NODE_ENV = 'test';
expect = require('chai').expect;
should = require('chai').should;
mongoose = require('mongoose');
require('mocha-mongoose');
server = require('../start');
User = require('../app/model/user');

describe('User using JS', function() {
  it('starts with no users', function(done) {
    User.find({}, function(error, users) {
      done();
    });
  });

  it('can add a new user', function(done) {
    User.create({
      username: "bob",
      password: "pisswird"
    }, function(error, user) {
      User.find({}, function(error, users) {
        should.not.exist(error);
        expect(users.length).to.be(1);
        done();
      });
    });
  });

  it('must have a username', function(done) {
    var user;
    user = new User({
      password: "pisswird"
    });
    user.save(function(error, user) {
      should.exist(error);
      console.log(error);
      expect(error.message).to.eq("");
      done();
    });
  });
});
