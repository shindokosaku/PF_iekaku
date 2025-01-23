class Corporate_user::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :destroy]

      def index
        @questions = Question.order(created_at: :desc).page(params[:page])
      end
  
      def show
        @answers = @question.question_answers.includes(:corporate_user)
        @answer = @question.question_answers.new # 空の回答オブジェクトを初期化
      end
  
      def destroy
        if @question.destroy
          redirect_to corporate_user_questions_path, notice: "質問を削除しました。"
        else
          redirect_to corporate_user_questions_path, alert: "質問の削除に失敗しました。"
        end
      end
  
      private

      def set_question
        @question = Question.find(params[:id])
      end
      def authenticate_corporate_user!
        redirect_to new_user_session_path unless current_user&.corporate_user?
      end
end
