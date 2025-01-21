class ChangeBodyToNullableInRooms < ActiveRecord::Migration[6.1]
  def change
    change_column_null :rooms, :body, true
  end
end
