class Public::QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(created_at: :desc)# 質問を最新順に表示
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to questions_path, notice: '質問が投稿されました。'
    else
      render :homes/top, alert: "質問の投稿に失敗しました。"
    end
  end

  def show 
    @question = Question.find(params[:id])
    @question_answers = @question.question_answers
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
