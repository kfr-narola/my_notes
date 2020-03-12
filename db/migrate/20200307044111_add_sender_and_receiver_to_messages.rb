class AddSenderAndReceiverToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :sender, foreign_key: true
    add_reference :messages, :receiver, foreign_key: true
  end
end
