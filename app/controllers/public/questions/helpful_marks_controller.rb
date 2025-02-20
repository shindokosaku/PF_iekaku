class Public::Questions::HelpfulMarksController < ApplicationController
#  module Questions
#    class HelpfulMarksController < ApplicationController
      before_action :set_question

      def toggle
        @questions = Question.includes(:helpful_marks, :question_answers).page(params[:page]).per(10)
        @helpful_mark =@question.helpful_marks.find_or_initialize_by(
          user:current_user,
          ip_address: current_user ? nil : request.remote_ip
        )

        @liked = if @helpful_mark.persisted?
                   @helpful_mark.destroy
                   false
                 else
                   @helpful_mark.save!
                   true
                 end

        respond_to do |format|
          format.html { redirect_to question_path(@question)}
          format.json { render json: {liked: @liked, count: @question.helpful_marks.count } }
        end
      end

      private

      def set_question
        @question = Question.find(params[:question_id])
      end
#    end
#  end
end
