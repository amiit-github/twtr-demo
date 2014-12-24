Backbone = require 'Backbone'
User = require 'apps/auth/models/User'

class FollowingList extends Backbone.Collection

  model: User

  url: ->
    "<?= settings.baseURL ?>/users/#{@user.id}/following"

module.exports = FollowingList
