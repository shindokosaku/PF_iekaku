class Public::QuestionsController < ApplicationController

  def index
    @questions = Question.order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to public_questions_path, notice: "質問を投稿しました。"
    else
      render :new, alert: "質問の投稿に失敗しました。"
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
