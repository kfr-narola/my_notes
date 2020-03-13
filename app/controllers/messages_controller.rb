class MessagesController < ApplicationController
  def index
    @users_list = User.where.not(id: current_user.id)
    @admin_list = Admin.all
  end

  def show
    if params[:sender_type]=="Admin"
      @user = Admin.find_by(id: params[:id])
    else
      @user = User.find_by(id: params[:id])
    end
    puts "========================"
    puts params[:id]
    puts @user.to_json
    @messages = @user.messages_with current_user
    @new_message = Message.new(sender_id:current_user.id, receiver_id: @user.id)
    puts @new_message.to_json
  end

  def create
    msg = Message.new(message_params)
    msg.sender = current_user
    msg.receiver_type = "Admin"
    msg.save

    if msg.image.attached?
      ActionCable.server.broadcast "chat_channel", message: msg.description, sender: msg.sender_id, receiver:msg.receiver_id, image: url_for(msg.image)
    else
      ActionCable.server.broadcast "chat_channel", message: msg.description, sender: msg.sender_id, receiver:msg.receiver_id
    end
    respond_to do | format |
      format.html { render :layout => false }
      format.js { render :layout => false }
    end
  end

  private
  def message_params
    params.require(:message).permit(:description, :sender_id, :sender_type, :receiver_id, :image)
  end
end
