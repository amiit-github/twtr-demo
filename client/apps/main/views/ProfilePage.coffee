Backbone = require 'Backbone'
TweetList = require '../models/TweetList'
TweetListView = require './TweetListView'
FollowingList = require '../models/FollowingList'
FollowerList = require '../models/FollowerList'
UserListView = require './UserListView'
WhoToFollowCard = require './WhoToFollowCard'
ProfileSummaryView = require './ProfileSummaryView'

class ProfilePage extends Backbone.View

  template: _.template(require '../templates/ProfilePage.html')

  events:
    'click .profile-nav li': 'selectTab'

  initialize: ->
    @$el.html @template()

    # Show "Who to Follow" card in the sidebar
    @whoToFollowCard = new WhoToFollowCard()
    @$('aside').append @whoToFollowCard.render().el

    # Add profile summary view
    @profileSummaryView = new ProfileSummaryView {model: app.currentUser}
    @$('#content-area').prepend @profileSummaryView.render().el

  render: =>
    @$('.profile-nav li:first-child').click()
    @

  selectTab: (e) ->
    $tab = $(e.currentTarget)
    tabName = $tab.attr('data-tab')
    $tab.siblings().removeClass('active')
    $tab.addClass('active')

    switch tabName
      when 'tweets'
        @showTweets()
      when 'following'
        @showFollowing()
      when 'followers'
        @showFollowers()

  showTweets: ->
    # Create a TweetList collection
    tweets = new TweetList
    tweets.type = 'tweets'
    tweets.user = app.currentUser

    # Show the tweets
    v = new TweetListView {collection: tweets}
    @$('.list-view').html v.render().el

  showFollowing: ->
    # Show people I am following
    following = new FollowingList
    following.user = app.currentUser
    v = new UserListView {collection: following, type: 'following'}
    @$('.list-view').html v.render().el

  showFollowers: ->
    # Show my followers
    followers = new FollowerList
    followers.user = app.currentUser
    v = new UserListView {collection: followers, type: 'followers'}
    @$('.list-view').html v.render().el

module.exports = ProfilePage
