#
# BaseApp is in charge of logging, CSRF, JSON caching, etc.
#

Backbone = require 'Backbone'
Logger = require 'muffin/Logger'

class App

  initialize: ->
    # Create logger
    window.logging = new Logger(logLevel = '<?- settings.logLevel ?>')

    # Alias "_id" to "id" globally to work with MongoDB
    Backbone.Model.prototype.idAttribute = "_id";

    # Cancel the default actions for links
    $(document).on 'click', 'a', (e) ->
      $a = $(e.currentTarget)
      href = $a.attr('href')
      if $a.attr('target')
        true
      else if /#$/.test(href)
        e.stopPropagation()
        e.preventDefault()
        false
      else
        e.preventDefault()
        window.location.href = href

    # Ajax setup
    $.ajaxSetup
      headers:
        "X-XSRF-Header": "X" # Prevent CSRF attacks
        "cache-control": "no-cache" # Prevent iOS6 from caching AJAX POST requests
      cache: false # Disable JSON caching on IE

module.exports = App
