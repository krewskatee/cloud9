App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.content.blank?
      $('#message-wr').append '<div class="message-content">'+ data.content + '</div>'


$(document).on 'turbolinks:load', ->
  submit_message()

submit_message = () ->
  $('#message-content').on 'keydown', (event) ->
    if event.keyCode is 13
      $('input').click()
      event.target.value = ""
      event.preventDefault()
