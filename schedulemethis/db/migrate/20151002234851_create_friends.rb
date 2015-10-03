class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :user_from
      t.references :user_to, index: true, foreign_key: true
      t.boolean :pending

      t.timestamps null: false
    end
  end
end
