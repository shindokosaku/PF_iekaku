class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|

      t.integer :user_id, null: false
      t.integer :admin_id, null: true
      t.text :body, null: false
      t.timestamps
    end
  end
end
