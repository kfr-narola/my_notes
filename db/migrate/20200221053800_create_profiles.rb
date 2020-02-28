class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :username
      t.integer :phone
      t.integer :gender, default:0
      t.date :birthdate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
