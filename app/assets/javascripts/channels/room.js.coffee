App.room = App.cable.subscriptions.create {channel: "RoomChannel", room:  gon.chat_id},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.content.blank?
      $('#message-wr').append '<div class="message-content">'+ data.username+ ': ' + data.content + '</div>'
