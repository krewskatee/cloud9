App.room = App.cable.subscriptions.create {channel: "RoomChannel", room:  gon.chat_id, user: gon.user_id},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.friend_request_content
      $('.alert-wrapper').append '<div class="alert alert-success">' + '<p class="alert-message">' + "You have received a new friends request!" + '</div>' +'</div>'
      $('.alert').fadeIn(500).delay(1000).fadeOut(1000);;
    unless data.content.blank?
      $('#message-wr').append '<div class="message-content">'+ data.username+ ': ' + data.content + '</div>'
