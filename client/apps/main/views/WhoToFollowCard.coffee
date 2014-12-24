Backbone = require 'Backbone'
RecommendedList = require '../models/RecommendedList'

class WhoToFollowCard extends Backbone.View

  className: 'card'
  template: _.template(require '../templates/WhoToFollowCard.html')
  userTemplate: _.template(require '../templates/_user_to_follow.html')

  events:
    'click .user-to-follow-actions button': 'follow'

  initialize: ->
    @$el.html @template()

    # Set up data structures backing the view
    @collection = new RecommendedList
    @collection.user = app.currentUser
    @collection.on 'reset', @render
    @collection.fetch {reset: true}

  render: =>
    $list = @$('.recommended-users').empty()
    @collection.each (user) =>
      $list.append @userTemplate({user: user.toJSON()})
    @

  follow: (e) ->
    $li = $(e.target).closest('.user-to-follow')
    userId = $li.attr('data-id')
    app.currentUser.follow userId, (err) =>
      if err
        console.log err
      else
        index = $li.index()
        model = @collection.at(index)
        @collection.remove model
        $li.remove()
        app.trigger 'follow:user'

module.exports = WhoToFollowCard
