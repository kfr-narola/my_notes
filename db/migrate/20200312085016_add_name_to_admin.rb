class AddNameToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :username, :string
  end
end
