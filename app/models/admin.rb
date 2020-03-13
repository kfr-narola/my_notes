class Admin < ApplicationRecord
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy, as: :sender
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy, as: :receiver
  def messages_with(chat_user)
    # Message.where("(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id = ?)", self.id, chat_user, chat_user, self.id).order(:created_at)
    # Message.where(sender:User.first,receiver:Admin.first).or(Message.where(receiver:User.first,sender:Admin.first))
    # Message.where("(sender: ? ,receiver: ? ).or(Message.where(receiver: ? ,sender: ? ))", self, chat_user, self, chat_user).order(:created_at)
    Message.where(sender: self,receiver: chat_user).or(Message.where(sender: chat_user ,receiver: self)).order(:created_at)
  end
end
