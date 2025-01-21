class ChangeAdminIdToBeNullableInMessages < ActiveRecord::Migration[6.1]
  def change
    change_column_null :messages, :admin_id, true
  end
end
