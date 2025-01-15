class Question < ApplicationRecord

  belongs_to :user
  has_many :question_answers, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
