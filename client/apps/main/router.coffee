Backbone = require 'Backbone'

class Router extends Backbone.Router

  routes:
    '':                       'index'

    'me':                     'showProfile'

    # Default action
    '*actions':                 'index'

  initialize: -> {}

  index: ->
    IndexPage = require './views/IndexPage'
    v = new IndexPage()
    app.layout.setView v
    app.layout.selectTab 'home'

  showProfile: ->
    ProfilePage = require './views/ProfilePage'
    v = new ProfilePage()
    app.layout.setView v
    app.layout.selectTab 'me'

module.exports = Router
