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
    # attach = params[:message][:image]
    # url = Hash.new
    # cnt = 0
    # puts params
    # # puts file.original_filename
    # # file_name = Time.now.to_i.to_s + file.original_filename
    # # path = File.join(Rails.root.join("public", "mail", "attach", file_name))
    # # File.open(path, "wb") { |f| f.write(file.read) }
    # # url.store(file_name, path)


    msg = Message.create(message_params)

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
    params.require(:message).permit(:description, :sender_id, :receiver_id, :image)
  end
end
