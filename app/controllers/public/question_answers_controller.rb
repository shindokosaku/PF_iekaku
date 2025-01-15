class Public::QuestionAnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @question_answer = @question.question_answers.new(question_answer_params)
    if @question_answer.save
      redirect_to question_path(@question), notice: '回答を投稿しました。'
    else
      flash[:alert] = '回答の投稿に失敗しました。'
      redirect_to question_path(@question)
    end  
end

private

  def question_answer_params
    params.require(:question_answer).permit(:body, :admin_id)
  end
end