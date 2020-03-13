class AddSenderAndReceiverToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :sender, polymorphic: true
    add_reference :messages, :receiver, polymorphic: true
  end
end
