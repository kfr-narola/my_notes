class Admins::MessagesController < AdminController
  def index
    @users = User.all
  end

  def show
    @current_ability ||= Ability.new(current_admin)
    @user = User.find_by(id: params[:id])
    puts "========================"
    puts params[:id]
    puts @user.to_json
    @messages = @user.messages_with current_admin
    @new_message = Message.new(sender:current_admin, receiver_id: @user.id)
    puts @new_message.to_json
  end

  def create
    @current_ability ||= Ability.new(current_admin)
    msg = Message.new(message_params)
    msg.sender = current_admin
    sender = current_admin
    msg.save
    if msg.image.attached?
      ActionCable.server.broadcast "chat_channel", message: msg.description, sender: current_admin.id, sender_type:"Admin", receiver:msg.receiver_id, receiver_type:"User", image: url_for(msg.image)
    else
      ActionCable.server.broadcast "chat_channel", message: msg.description, sender: current_admin.id, sender_type:"Admin", receiver:msg.receiver_id, receiver_type:"User"
    end
    respond_to do | format |
      format.html { render :layout => false }
      format.js { render :layout => false }
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:description, :sender_id, :sender_type, :receiver_id, :receiver_type, :image)
  end
end
