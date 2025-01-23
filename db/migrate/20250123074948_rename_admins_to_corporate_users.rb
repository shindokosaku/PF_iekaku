class RenameAdminsToCorporateUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :admins, :corporate_users
  end
end
