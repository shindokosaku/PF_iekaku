class AddResponseStatusToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :response_status, :string, default: "未対応", null: false
  end
end
