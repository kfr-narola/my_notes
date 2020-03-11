class MessagesController < ApplicationController
  def index
    @users_list = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find_by(id: params[:id])
    @messages = @user.messages_with current_user.id
    @new_message = Message.new(sender_id:current_user.id, receiver_id: @user.id)
    puts @new_message.to_json
  end

  def create
    msg = Message.create(message_params)
    ActionCable.server.broadcast "chat_channel", message: msg.description, sender: msg.sender_id, receiver:msg.receiver_id
    @last_msg = msg
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private
  def message_params
    params.require(:message).permit(:description, :sender_id, :receiver_id)
  end
end
