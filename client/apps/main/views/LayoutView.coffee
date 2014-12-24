Backbone = require 'Backbone'
ComposeView = require './ComposeView'
require 'buckwilson/Lightbox_me'

class LayoutView extends Backbone.View

  template: _.template(require '../templates/LayoutView.html')

  events:
    'click .btn-compose': 'showComposeView'
    'click .btn-logout': 'logout'

  initialize: ->
    @rendered = false

  render: =>
    @$el.html @template()
    @rendered = true
    @

  setView: (v) ->
    @render() unless @rendered
    @$('#page-container').html v.render().el

  showComposeView: ->
    v = new ComposeView()
    v.render()
    v.$el.lightbox_me
      centered: true
      destroyOnClose: true

  selectTab: (tab) ->
    $tab = @$(".nav.navbar-nav li[data-tab='#{tab}']")
    $tab.siblings().removeClass('active')
    $tab.addClass('active')

  logout: (e) ->
    apps.auth.logout()

module.exports = LayoutView
