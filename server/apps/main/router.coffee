TweetController = require './controllers/TweetController'
FollowingController = require './controllers/FollowingController'
FollowerController = require './controllers/FollowerController'
RecommendedController = require './controllers/RecommendedController'

# Router
router = (app) ->
  app.namespace '/users/:id', ->
    # Tweets
    app.get '/tweets', app.authenticate, TweetController.index
    app.get '/timeline', app.authenticate, TweetController.timeline
    app.post '/tweets', app.authenticate, TweetController.create
    app.delete '/tweets/:tid', app.authenticate, TweetController.destroy

    # Following
    app.get '/following', app.authenticate, FollowingController.index
    app.post '/follow/:fid', app.authenticate, FollowingController.create
    app.post '/unfollow/:fid', app.authenticate, FollowingController.destroy

    # Followers
    app.get '/followers', app.authenticate, FollowerController.index

    # Recommended people to follow
    app.get '/recommended', app.authenticate, RecommendedController.index

module.exports = router
