mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
crypto = require 'crypto'

setEmail = (email) ->
  # Derive username from email
  email = email.toLowerCase()
  @username = email.split('@')[0]
  hash = crypto.createHash('md5').update(email).digest('hex')
  @profileImageUrl = 'http://www.gravatar.com/avatar/' + hash
  email

UserSchema = new Schema
  email: {type: String, required: true, unique: true, set: setEmail}
  username: {type: String, required: true}
  name: {type: String, required: true}
  openId: {type: String, required: true}
  created_at: { type: Date, default: Date.now }
  updated_at: Date

  profileImageUrl: String

  tweets: [{type: ObjectId, ref: 'Tweet'}]
  tweetsCount: {type: Number, default: 0}

  following: [{type: ObjectId, ref: 'User'}]
  followingCount: {type: Number, default: 0}

  followers: [{type: ObjectId, ref: 'User'}]
  followersCount: {type: Number, default: 0}

User = mongoose.model('User', UserSchema)
module.exports = User
