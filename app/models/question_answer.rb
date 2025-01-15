class QuestionAnswer < ApplicationRecord
  
  belongs_to :admin
  has_many :question, dependent: :destroy
  
end
