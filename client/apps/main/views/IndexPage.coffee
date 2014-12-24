Backbone = require 'Backbone'
TweetList = require '../models/TweetList'
TweetListView = require './TweetListView'
WhoToFollowCard = require './WhoToFollowCard'
ProfileSummaryCard = require './ProfileSummaryCard'

class IndexPage extends Backbone.View

  template: _.template(require '../templates/IndexPage.html')

  events: {}

  initialize: ->
    @$el.html @template()

    # Show profile summary card in the sidebar
    @profileSummaryCard = new ProfileSummaryCard {model: app.currentUser}
    @$('aside').append @profileSummaryCard.render().el

    # Show "Who to Follow" card in the sidebar
    @whoToFollowCard = new WhoToFollowCard()
    @$('aside').append @whoToFollowCard.render().el

    # Create a TweetList collection
    tweets = new TweetList()
    tweets.type = 'timeline'
    tweets.user = app.currentUser

    # Show tweets in the content area
    @tweetListView = new TweetListView {collection: tweets}
    @$('.tweet-list-view').html @tweetListView.render().el

  render: => @

module.exports = IndexPage
