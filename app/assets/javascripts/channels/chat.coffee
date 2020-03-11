App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # $('#messages_body').append("<div class='alert'><p>"+ data['sender']+" : " + data['message'] + "</p></div>")
    user = $(document).find('input[id="user_id_for_chat"]').val()
    if parseInt(user) is parseInt(data['sender'])
      $("#message_body").append("<div class='row justify-content-end'><div class='col-4 sender'>"+ data['message']+ "</div><div class='col-1'></div>'</div>")

    if parseInt(user) is parseInt(data['receiver'])
      $("#message_body").append("<div class='row justify-content-start'><div class='col-1'></div><div class='col-4 receiver'>" + data['message']+ "</div></div>")
    # Called when there's incoming data on the websocket for this channel

  # speak: (message, sender, receiver) ->
  #   @perform 'speak', message: message, sender: sender, receiver:receiver

# $(document).on 'click', '[data-behavior~=send_msg]', (event) ->
#   # if event.keyCode is 13 # return/enter = send
#     sender = $(document).find('input[name="id_of_sender"]').val()
#     receiver = $(document).find('input[name="id_of_receiver"]').val()
#     alert(sender, receiver)
#     msg = event.target.value
#     App.room.speak msg,sender,receiver
#     event.target.value = ''
#     event.preventDefault()
