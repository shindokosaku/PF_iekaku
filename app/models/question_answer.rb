class QuestionAnswer < ApplicationRecord
  
  belongs_to :admin
  belongs_to :question
  
end
