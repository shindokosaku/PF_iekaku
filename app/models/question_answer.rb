class QuestionAnswer < ApplicationRecord
  
  belongs_to :corporate_user
  belongs_to :question

  def self.looks(search, word)
    search == "partial_match"
    @question_answer = QuestionAnswer.where("body LIKE?","%#{word}%")
  end

end

