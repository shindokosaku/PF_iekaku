class Question < ApplicationRecord
  paginates_per 5
  belongs_to :user
  has_many :question_answers, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def self.looks(search, word)
    search == "partial_match"
    @question = Question.where("body LIKE?","%#{word}%")
  end
end
