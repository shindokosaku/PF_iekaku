class HomesController < ApplicationController
  def top
    @questions = Question.order(created_at: :desc).limit(5)
  end

  def about
  end
end
