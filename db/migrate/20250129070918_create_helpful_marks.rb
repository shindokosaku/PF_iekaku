class CreateHelpfulMarks < ActiveRecord::Migration[6.1]
  def change
    create_table :helpful_marks do |t|
      t.references :question, null: false, foreign_key: true
      t.references :user
      t.references :corporate_user, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
     # user_id or corporate_user or ip_address のどちらかが重複しないように制約を追加
     add_index :helpful_marks, [:question_id, :user_id], unique: true,where:"user_id IS NOT NULL"
     add_index :helpful_marks, [:question_id, :corporate_user_id], unique: true, where: "corporate_user_id IS NOT NULL"
     add_index :helpful_marks, [:question_id, :ip_address], unique: true, where: "ip_address IS NOT NULL"
  end
end
