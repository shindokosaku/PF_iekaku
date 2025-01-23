
  class RenameIsAdminActiveToIsCorporateUserActiveInCorporateUsers < ActiveRecord::Migration[6.1]
    def change
      rename_column :corporate_users, :is_admin_activ, :is_corporate_user_active
    end
  end

