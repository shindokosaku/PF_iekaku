class Public::QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
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

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question= Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = '質問を更新しました。'
      redirect_to questions_path(@question)
    else
      flash[:alert] = '質問の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    question = Question.find(params[:id])
    if question.user == current_user # 投稿者本人のみ削除可能
      question.destroy
      flash[:notice] = '質問を削除しました。'
      redirect_to questions_path
    else
      flash[:alert] = '権限がありません。'
      redirect_to questions_path
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
