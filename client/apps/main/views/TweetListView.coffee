Backbone = require 'Backbone'

class TweetListView extends Backbone.View

  template: _.template(require '../templates/TweetListView.html')
  tweetTemplate: _.template(require '../templates/_tweet.html')

  events: {}

  initialize: ->
    @$el.html @template()

    # Set up data structures backing the view
    @collection.on 'reset', @render
    @collection.on 'add', @addItem
    @collection.on 'remove', @removeItem
    @collection.fetch {reset: true}

    # Listen to "send:tweet" event
    @listenTo app, 'send:tweet', ->
      @collection.fetch()

  addItem: (tweet) =>
    $list = @$('.tweets')
    $list.prepend @tweetTemplate({tweet: tweet.toJSON(), creator: tweet.creator.toJSON()})

  render: =>
    $list = @$('.tweets').empty()
    @collection.each (tweet) =>
      $list.append @tweetTemplate({tweet: tweet.toJSON(), creator: tweet.creator.toJSON()})
    @

module.exports = TweetListView
