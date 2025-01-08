class CreateQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :question_answers do |t|

      t.integer :question_id, null: false
      t.integer :admin_id, null: false
      t.text :body, null:false
      t.timestamps
    end
  end
end
