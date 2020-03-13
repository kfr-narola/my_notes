App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # $('#messages_body').append("<div class='alert'><p>"+ data['sender']+" : " + data['message'] + "</p></div>")
    user = $(document).find('input[id="user_id_for_chat"]').val()
    user_img = $(document).find('#user_profile').attr('src')
    username = $(document).find('#current_user').text()
    sendername = $(document).find('#current_sender').text()
    sender_img = $(document).find('#sender_profile').attr('src')
    if parseInt(user) is parseInt(data['sender'])
      if data['image']?
        $("#message_body").append("<div class='row justify-content-end'><div class='col-4 sender'><text class='msg_heading'>" + username + "</text><br>"+ data['message']+ "<center><img class='msg_image' src='" + data['image']+ "'></center></div><div class='col-1'><img class='icon' style='width:50px;height:50px;' src='" + user_img + "'></div></div>")
      else
        $("#message_body").append("<div class='row justify-content-end'><div class='col-4 sender'><text class='msg_heading'>" + username + "</text><br>"+ data['message']+ "<center></div><div class='col-1'><img class='icon' style='width:50px;height:50px;' src='" + user_img + "'></div></div>")

    if parseInt(user) is parseInt(data['receiver'])
      if data['image']?
        $("#message_body").append("<div class='row justify-content-start'><div class='col-1'></div><div class='col-4 receiver'><text class='msg_heading'>" + sendername + "</text><br>" + data['message']+ "<img class='msg_image' src='" + data['image']+ "'></center></div></div>")
      else
        $("#message_body").append("<div class='row justify-content-start'><div class='col-1'><img src='" + sender_img + "' class='icon' style='width:50px;height:50px;'></div><div class='col-4 receiver'><text class='msg_heading'>" + sendername + "</text><br>" + data['message']+ "</div></div>")
    # Called when there's incoming data on the websocket for this channel

  # speak: (message, sender, receiver) ->
  #   @perform 'speak', message: message, sender: sender, receiver:receiver

# $(document).on 'cliconk', '[data-behavior~=send_msg]', (event) ->
#   # if event.keyCode is 13 # return/enter = send
#     sender = $(document).find('input[name="id_of_sender"]').val()
#     receiver = $(document).find('input[name="id_of_receiver"]').val()
#     alert(sender, receiver)
#     msg = event.target.value
#     App.room.speak msg,sender,receiver
#     event.target.value = ''
#     event.preventDefault()
