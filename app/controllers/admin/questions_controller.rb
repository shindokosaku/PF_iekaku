class Admin::QuestionsController < ApplicationController
   before_action :authenticate_admin!
  
      def index
        @questions = Question.order(created_at: :desc)
      end
  
      def show
        @question = Question.find(params[:id])
      end
  
      def destroy
        @question = Question.find(params[:id])
        if @question.destroy
          redirect_to admin_questions_path, notice: "質問を削除しました。"
        else
          redirect_to admin_questions_path, alert: "質問の削除に失敗しました。"
        end
      end
  
      private
  
      def authenticate_admin!
        # 管理者認証を行うためのロジックを追加
        redirect_to new_user_session_path unless current_user&.admin?
      end

end
