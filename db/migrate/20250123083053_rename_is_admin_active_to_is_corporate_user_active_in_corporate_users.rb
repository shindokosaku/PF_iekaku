
class RenameIsAdminActiveToIsCorporateUserActiveInCorporateUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :corporate_users, :is_admin_active, :is_corporate_user_active
  end
end

