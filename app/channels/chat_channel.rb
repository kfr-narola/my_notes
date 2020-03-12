class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # def speak(data)
  #   Message.create(content: data['message'], sender: data['sender'], receiver: data['receiver'])
  # end
end
