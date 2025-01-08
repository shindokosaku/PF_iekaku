class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|

      t.integer :room_id, null: false
      t.integer :user_id, null: false
      t.integer :admin_id, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
