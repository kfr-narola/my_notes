class AddStatusToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :status, :integer, default:0
  end
end
