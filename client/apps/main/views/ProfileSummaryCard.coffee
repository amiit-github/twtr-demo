Backbone = require 'Backbone'

class ProfileSummaryCard extends Backbone.View

  className: 'card'
  template: _.template(require '../templates/ProfileSummaryCard.html')

  events: {}

  initialize: -> {}

  render: =>
    data = {user: @model.toJSON()}
    @$el.html @template(data)
    @

module.exports = ProfileSummaryCard
