mongoose = require 'mongoose'
mongoose.set('debug', true)

schema = new mongoose.Schema {
  username: {type: String, required: true}
  password: {type: String, required: true}
}

schema.statics.new_user = (username, password, callback) ->
  new @ {username: username, password: password}, callback

user = mongoose.model "User", schema

module.exports = mongoose.model "User", schema
