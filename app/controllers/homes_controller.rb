class HomesController < ApplicationController
  def top
    @questions = Question.order(created_at: :desc).limit(5)
    @question = Question.new
  end

  def about
  end
end
