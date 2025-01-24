class AllowNullForUserIdInMessages < ActiveRecord::Migration[6.1]
  def change
    change_column_null :messages, :user_id, true
  end
end

