passport = require 'passport'
GoogleStrategy = require('passport-google').Strategy
User = require './models/User'

# Serialization
passport.serializeUser (user, done) ->
  done(null, user._id)

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    done(err, user)

# Use Google strategy
passport.use(new GoogleStrategy {
  returnURL: 'http://localhost:4000/api/v1/verify'
  realm: 'http://localhost:4000/'
}, (identifier, profile, done) ->
  name = profile.displayName
  email = profile.emails[0].value

  user = User.findOne {email}, (err, user) ->
    if user
      user.name = name
      user.email = email
    else
      user = new User {openId: identifier, name, email}
    user.save (err) ->
      done(err, user)
)

# Router
router = (app) ->
  # Authentication middleware
  app.authenticate = (req, res, next) ->
    if req.session.passport.user?
      User.findById req.session.passport.user, (err, user) ->
        if user
          req.user = user
          next()
        else
          res.send(401)
    else
      res.send(401)

  app.get '/login', passport.authenticate('google')

  app.get '/verify', passport.authenticate('google', {
    successRedirect: '/'
    failureRedirect: '/#login'
  })

  app.get '/session', app.authenticate, (req, res) ->
    res.send {user: req.user}

  app.delete '/session', (req, res) ->
    req.logout()
    res.send({})

module.exports = router
