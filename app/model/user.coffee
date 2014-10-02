mongoose = require 'mongoose'
mongoose.set('debug', true)

userSchema = mongoose.Schema {
  username: String
  password: String
}

User = mongoose.model("User", userSchema)

module.exports = User
