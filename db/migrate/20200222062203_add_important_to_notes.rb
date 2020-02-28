class AddImportantToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :important, :integer, default:0
  end
end
