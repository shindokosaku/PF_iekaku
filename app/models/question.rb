class Question < ApplicationRecord
  paginates_per 5
  belongs_to :user
  has_many :question_answers, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
