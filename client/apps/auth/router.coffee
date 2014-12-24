Backbone = require 'Backbone'

class Router extends Backbone.Router

  routes:
    'login':                   'login'

  initialize: -> {}

  login: ->
    LoginPage = require './views/LoginPage'
    v = new LoginPage {el: 'body'}

module.exports = Router
