mongoose = require 'mongoose'
uniqueValidator = require 'mongoose-unique-validator'
#mongoose.set 'debug', true
bcrypt = require 'bcrypt'


userSchema = new mongoose.Schema {
  username: {type: String, required: true, unique: true}
  password: {type: String, required: true}
}

userSchema.plugin(uniqueValidator)

User = mongoose.model "User", userSchema

User.prototype.validate_password = (password, callback)->
  bcrypt.compareSync(password, @password)

User.prototype._realSave = User.prototype.save
User.prototype.save = (callback)->
  @password = bcrypt.hashSync @password, 10
  this._realSave (error, saved_user)->
    callback(error, saved_user)

module.exports = User
