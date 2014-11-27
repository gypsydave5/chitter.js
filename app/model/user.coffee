mongoose = require 'mongoose'
uniqueValidator = require 'mongoose-unique-validator'
bcrypt = require 'bcrypt'


userSchema = new mongoose.Schema {
  username: {type: String, required: true, unique: true}
  password: {type: String, required: true}
}

userSchema.plugin(uniqueValidator)

User = mongoose.model "User", userSchema

User.validatePassword = (username, password, callback)->
  @find {username: username}, (error, user)->
    bcrypt.compare password, user[0].password, (error, result)->
      callback(error, result)

User.prototype._realSave = User.prototype.save
User.prototype.save = (callback)->
  @password = bcrypt.hashSync @password, 10
  this._realSave (error, saved_user)->
    callback(error, saved_user)

module.exports = User
