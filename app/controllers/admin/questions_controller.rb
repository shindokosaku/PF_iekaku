module Admin
  class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :destroy, :toggle_helpful]

      def index
        @questions = Question.order(created_at: :desc).page(params[:page])
      end
  
      def show
        @answers = @question.question_answers.includes(:corporate_user)
        @answer = @question.question_answers.new # 空の回答オブジェクトを初期化
      end
  
      def destroy
        if @question.destroy
          redirect_to admin_questions_path, notice: "質問を削除しました。"
        else
          redirect_to admin_questions_path, alert: "質問の削除に失敗しました。"
        end
      end

      def toggle_helpful
        @question = Question.find(params[:id])
        mark = @question.helpful_marks.find_by(user_id: current_user&.id, ip_address: request.remote_ip)
  
        if mark
          mark.destroy
        else
          @question.helpful_marks.create(corporate_user_id: current_corporate_user&.id, ip_address: request.remote_ip)
        end
  
        render json: { count: @question.helpful_marks.count }
      end
  
  
      private

      def set_question
        @question = Question.find(params[:id])
      end

      def authenticate_corporate_user!
        redirect_to new_user_session_path unless current_user&.corporate_user?
      end
  end
end
