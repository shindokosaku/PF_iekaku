class AddUniqueIndexToUsersNickname < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :nickname, unique: true
  end
end
