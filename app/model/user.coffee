mongoose = require 'mongoose'
uniqueValidator = require 'mongoose-unique-validator'
#mongoose.set 'debug', true

userSchema = new mongoose.Schema {
  username: {type: String, required: true, unique: true}
  password: {type: String, required: true}
}

userSchema.plugin(uniqueValidator)

User = mongoose.model "User", userSchema

module.exports = mongoose.model "User", userSchema
