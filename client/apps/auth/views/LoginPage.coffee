Backbone = require 'Backbone'

class LoginPage extends Backbone.View

  template: _.template(require '../templates/LoginPage.html')

  events: {}

  initialize: ->
    @$el.html @template()

  render: => @

module.exports = LoginPage
