Backbone = require 'Backbone'

class User extends Backbone.Model
  urlRoot: "<?= settings.baseURL ?>/users"

  follow: (userId, callback) ->
    $.ajax
      type: 'POST'
      url: "<?= settings.baseURL ?>/users/#{@id}/follow/#{userId}"
      contentType: 'application/json'
      data: JSON.stringify({})
      dataType: 'json'
      success: (data, status, xhr) =>
        logging.info "Did follow user #{userId}"
        callback(null)
      error: (xhr, status, error) =>
        logging.error "Failed to follow user #{userId}"
        callback(error)

  unfollow: (userId, callback) ->
    $.ajax
      type: 'POST'
      url: "<?= settings.baseURL ?>/users/#{@id}/unfollow/#{userId}"
      contentType: 'application/json'
      data: JSON.stringify({})
      dataType: 'json'
      success: (data, status, xhr) =>
        logging.info "Did unfollow user #{userId}"
        callback(null)
      error: (xhr, status, error) =>
        logging.error "Failed to unfollow user #{userId}"
        callback(error)

module.exports = User
