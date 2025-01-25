class SearchesController < ApplicationController
 

  def search
    @keyword = params[:keyword]
    @questions = Question.where('title LIKE ? OR body LIKE ?', "%#{@keyword}%", "%#{@keyword}%")
    @question_answers = QuestionAnswer.where('body LIKE ?', "%#{@keyword}%")
    @total_count = @questions.size + @question_answers.size
  end
end


