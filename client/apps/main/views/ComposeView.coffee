Backbone = require 'Backbone'
Tweet = require '../models/Tweet'

class ComposeView extends Backbone.View

  template: _.template(require '../templates/ComposeView.html')

  events:
    'click .tweet-button': 'sendTweet'
    'keyup textarea': 'updateCounter'
    'keypress textarea': 'onKeypress'

  initialize: ->
    @$el.html @template()

  render: => @

  updateCounter: (e) ->
    $counter = @$('.compose-character-count')
    $tweetButton = @$('.tweet-button')

    text = @$('.compose-text').val().trim()
    valid = Tweet.isTextValid(text)

    remaining = Tweet.remainingCharsCount(text.length)
    $counter.text remaining

    if valid
      $counter.removeClass 'invalid'
      $tweetButton.removeAttr 'disabled'
    else if text.length is 0
      $counter.removeClass 'invalid'
      $tweetButton.attr 'disabled', 'disabled'
    else
      $counter.addClass 'invalid'
      $tweetButton.attr 'disabled', 'disabled'

  onKeypress: (e) ->
    if e.which is 13
      @sendTweet()
      false

  sendTweet: (e) ->
    text = @$('.compose-text').val()
    tweet = new Tweet
    tweet.creator = app.currentUser
    tweet.save {text},
      success: (model, response) =>
        @$('.compose-text').val('').trigger('keyup')
        app.trigger 'send:tweet', model
        logging.debug "Sent Tweet."
        @dismiss()
      error: (model, response) =>
        logging.debug "Failed to send Tweet."
    false

  dismiss: ->
    @$el.trigger('close')

module.exports = ComposeView
