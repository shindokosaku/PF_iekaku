class QuestionAnswer < ApplicationRecord
  
  belongs_to :corporate_user
  belongs_to :question
  
end
