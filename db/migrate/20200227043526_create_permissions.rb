class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.integer :access, default: 0
      t.references :note, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
