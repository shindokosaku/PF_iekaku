class Public::QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :edit, :show]
  
  def index
    @questions = Question.order(created_at: :desc).page(params[:page])
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to questions_path, notice: '質問が投稿されました。'
    else
      flash.now[:alert] = "質問の投稿に失敗しました。"  # 失敗時のフラッシュメッセージ
      render :homes_top  # 失敗時に現在のページを再レンダリング

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

  def toggle_helpful
    @question = Question.find(params[:id])
    mark = @question.helpful_marks.find_by(user_id: current_user&.id, ip_address: request.remote_ip)

    if mark
      mark.destroy
    else
      @question.helpful_marks.create(user_id: current_user&.id, ip_address: request.remote_ip)
    end

    render json: { count: @question.helpful_marks.count }
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
