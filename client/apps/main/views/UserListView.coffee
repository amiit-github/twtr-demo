Backbone = require 'Backbone'

class UserListView extends Backbone.View

  template: _.template(require '../templates/UserListView.html')
  userTemplate: _.template(require '../templates/_user.html')

  events:
    'mouseenter .btn-unfollow': 'showUnfollow'
    'mouseleave .btn-unfollow': 'showFollowing'
    'click .btn-follow': 'follow'
    'click .btn-unfollow': 'unfollow'

  initialize: (@options) ->
    @$el.html @template()

    # Set header
    @type = @options.type
    switch @type
      when 'following'
        @$('.users-header h3').text 'Following'
      when 'followers'
        @$('.users-header h3').text 'Followers'

    # Set up data structures backing the view
    @collection.on 'reset', @render
    @collection.fetch {reset: true}

    # Listen to 'follow:user' and 'unfollow:user' events
    @listenTo app, 'follow:user unfollow:user', ->
      @collection.fetch {reset: true}

  render: =>
    $list = @$('.users').empty()
    @collection.each (user) =>
      $list.append @userTemplate({user: user.toJSON(), type: @type})
    @

  showUnfollow: (e) ->
    $(e.target).text 'Unfollow'

  showFollowing: (e) ->
    $(e.target).text 'Following'

  follow: (e) ->
    $li = $(e.target).closest('.user')
    userId = $li.attr('data-id')
    app.currentUser.follow userId, (err) =>
      if err
        console.log err
      else
        app.trigger 'follow:user'

  unfollow: (e) ->
    $li = $(e.target).closest('.user')
    userId = $li.attr('data-id')
    app.currentUser.unfollow userId, (err) =>
      if err
        console.log err
      else
        app.trigger 'unfollow:user'

module.exports = UserListView
