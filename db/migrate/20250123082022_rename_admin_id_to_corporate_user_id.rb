class RenameAdminIdToCorporateUserId < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :admin_id, :corporate_user_id
    rename_column :question_answers, :admin_id, :corporate_user_id
    rename_column :rooms, :admin_id, :corporate_user_id
  end
end
