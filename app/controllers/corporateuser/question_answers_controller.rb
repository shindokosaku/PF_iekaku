class CorporateUser::QuestionAnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: [:edit, :update, :destroy]
  
  
  def create
    @answer = @question.question_answers.new(question_answer_params)
    @answer.corporate_user = current_corporate_user 
    
    if @answer.save
      flash[:notice] = "回答を投稿しました。"
      redirect_to corporate_user_question_path(@question)
    else
      flash[:alert] = '回答の投稿に失敗しました。'
      render "corporate_user/questions/show"
    end  
  end
  def edit
  end

  def update
    if @answer.update(question_answer_params)
      flash[:notice] = "回答を更新しました。"
      redirect_to corporate_user_question_path(@question)
    else
      flash[:alert] = "回答の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @answer.destroy
    flash[:notice] = "回答を削除しました。"
    redirect_to corporate_user_question_path(@question)
  end

private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.question_answers.find(params[:id])
  end

  def question_answer_params
    params.require(:question_answer).permit(:body)
  end

  def authenticate_corporate_user!
    redirect_to new_user_session_path unless current_user&.corporate_user?
  end
end
